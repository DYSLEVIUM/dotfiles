local M = {}
local merge_tb = vim.tbl_deep_extend
local api = vim.api

M.load_config = function()
    return require "core.default"
end

M.load_mappings = function(section, mapping_opt)
    vim.schedule(function()
        local function set_section_map(section_values)
            if section_values.plugin then
                return
            end

            section_values.plugin = nil

            for mode, mode_values in pairs(section_values) do
                local default_opts = merge_tb("force", {
                    mode = mode
                }, mapping_opt or {})
                for keybind, mapping_info in pairs(mode_values) do
                    -- merge default + user opts
                    local opts = merge_tb("force", default_opts, mapping_info.opts or {})

                    mapping_info.opts, opts.mode = nil, nil
                    opts.desc = mapping_info[2]

                    vim.keymap.set(mode, keybind, mapping_info[1], opts)
                end
            end
        end

        local mappings = require("core.utils").load_config().mappings

        if type(section) == "string" then
            mappings[section]["plugin"] = nil
            mappings = { mappings[section] }
        end

        for _, sect in pairs(mappings) do
            set_section_map(sect)
        end
    end)
end

M.lazy_load = function(plugin)
    api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
        group = api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
        callback = function()
            local file = vim.fn.expand "%"
            local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

            if condition then
                api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

                -- dont defer for treesitter as it will show slow highlighting
                -- This deferring only happens only when we do "nvim filename"
                if plugin ~= "nvim-treesitter" then
                    vim.schedule(function()
                        require("lazy").load {
                            plugins = plugin
                        }

                        if plugin == "nvim-lspconfig" then
                            vim.cmd "silent! do FileType"
                        end
                    end, 0)
                else
                    require("lazy").load {
                        plugins = plugin
                    }
                end
            end
        end
    })
end

M.signature_window = function(_, result, ctx, config)
    local bufnr, winner = vim.lsp.handlers.signature_help(_, result, ctx, config)
    local current_cursor_line = vim.api.nvim_win_get_cursor(0)[1]

    if winner then
        if current_cursor_line > 3 then
            vim.api.nvim_win_set_config(winner, {
                anchor = "SW",
                relative = "cursor",
                row = 0,
                col = -1,
            })
        end
    end

    if bufnr and winner then
        return bufnr, winner
    end
end

-- thx to https://github.com/seblj/dotfiles/blob/0542cae6cd9a2a8cbddbb733f4f65155e6d20edf/nvim/lua/config/lspconfig/init.lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local util = require "vim.lsp.util"
local clients = {}

local check_trigger_char = function(line_to_cursor, triggers)
    if not triggers then
        return false
    end

    for _, trigger_char in ipairs(triggers) do
        local current_char = line_to_cursor:sub(#line_to_cursor, #line_to_cursor)
        local prev_char = line_to_cursor:sub(#line_to_cursor - 1, #line_to_cursor - 1)
        if current_char == trigger_char then
            return true
        end
        if current_char == " " and prev_char == trigger_char then
            return true
        end
    end
    return false
end

local open_signature = function()
    local triggered = false

    for _, client in pairs(clients) do
        local triggers = client.server_capabilities.signatureHelpProvider.triggerCharacters

        -- csharp has wrong trigger chars for some odd reason
        if client.name == "csharp" then
            triggers = { "(", "," }
        end

        local pos = vim.api.nvim_win_get_cursor(0)
        local line = vim.api.nvim_get_current_line()
        local line_to_cursor = line:sub(1, pos[2])

        if not triggered then
            triggered = check_trigger_char(line_to_cursor, triggers)
        end
    end

    if triggered then
        local params = util.make_position_params()
        vim.lsp.buf_request(
            0,
            "textDocument/signatureHelp",
            params,
            vim.lsp.with(M.signature_window, {
                border = "single",
                focusable = false,
                silent = config.silent,
            })
        )
    end
end

M.setup = function(client)
    table.insert(clients, client)
    local group = augroup("LspSignature", { clear = false })
    vim.api.nvim_clear_autocmds { group = group, pattern = "<buffer>" }

    autocmd("TextChangedI", {
        group = group,
        pattern = "<buffer>",
        callback = function()
            -- Guard against spamming of method not supported after
            -- stopping a language serer with LspStop
            local active_clients = vim.lsp.get_active_clients()
            if #active_clients < 1 then
                return
            end
            open_signature()
        end,
    })
end

M.root_patterns = { ".git", "lua" }

M.get_root = function()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace and vim.tbl_map(function(ws)
                return vim.uri_to_fname(ws.uri)
            end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

M.telescope = function(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
        if builtin == "files" then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        if opts.cwd and opts.cwd ~= vim.loop.cwd() then
            opts.attach_mappings = function(_, map)
                map("i", "<a-c>", function()
                    local action_state = require("telescope.actions.state")
                    local line = action_state.get_current_line()
                    M.telescope(
                        params.builtin,
                        vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
                    )()
                end)
                return true
            end
        end

        require("telescope.builtin")[builtin](opts)
    end
end

M.on_very_lazy = function(fn)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            fn()
        end,
    })
end

---@param plugin string
M.has = function(plugin)
    return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

M.fg = function(name)
    ---@type {foreground?:number}?
    local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
    local fg = hl and hl.fg or hl.foreground
    return fg and { fg = string.format("#%06x", fg) }
end

M.on_attach = function(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end



return M
