local Utils = require("core.utils")

return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
        {
            "ahmedkhalf/project.nvim",
            event = "VeryLazy",
        }
    },
    keys = {
        { "<leader>,",       "<cmd>Telescope buffers show_all_buffers=true<cr>",    desc = "Switch Buffer" },
        { "<leader>/",       Utils.telescope("live_grep"),                          desc = "Grep (root dir)" },
        { "<leader>:",       "<cmd>Telescope command_history<cr>",                  desc = "Command History" },
        { "<leader><space>", Utils.telescope("files"),                              desc = "Find Files (root dir)" },
        -- find
        { "<leader>fb",      "<cmd>Telescope buffers<cr>",                          desc = "Buffers" },
        { "<leader>ff",      Utils.telescope("files"),                              desc = "Find Files (root dir)" },
        { "<leader>fF",      Utils.telescope("files", { cwd = false }),             desc = "Find Files (cwd)" },
        -- { "<leader>fr",      "<cmd>Telescope oldfiles<cr>",                         desc = "Recent" },
        -- { "<leader>fR",      Utils.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        -- git
        { "<leader>gc",      "<cmd>Telescope git_commits<CR>",                      desc = "commits" },
        { "<leader>gs",      "<cmd>Telescope git_status<CR>",                       desc = "status" },
        -- search
        { "<leader>sa",      "<cmd>Telescope autocommands<cr>",                     desc = "Auto Commands" },
        { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",        desc = "Buffer" },
        { "<leader>sc",      "<cmd>Telescope command_history<cr>",                  desc = "Command History" },
        { "<leader>sC",      "<cmd>Telescope commands<cr>",                         desc = "Commands" },
        { "<leader>sd",      "<cmd>Telescope diagnostics bufnr=0<cr>",              desc = "Document diagnostics" },
        { "<leader>sD",      "<cmd>Telescope diagnostics<cr>",                      desc = "Workspace diagnostics" },
        { "<leader>sg",      Utils.telescope("live_grep"),                          desc = "Grep (root dir)" },
        { "<leader>sG",      Utils.telescope("live_grep", { cwd = false }),         desc = "Grep (cwd)" },
        { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                        desc = "Help Pages" },
        {
            "<leader>sH",
            "<cmd>Telescope highlights<cr>",
            desc =
            "Search Highlight Groups"
        },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>",                    desc = "Key Maps" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>",                  desc = "Man Pages" },
        { "<leader>sm", "<cmd>Telescope marks<cr>",                      desc = "Jump to Mark" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>",                desc = "Options" },
        { "<leader>sR", "<cmd>Telescope resume<cr>",                     desc = "Resume" },
        { "<leader>sw", Utils.telescope("grep_string"),                  desc = "Word (root dir)" },
        { "<leader>sW", Utils.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
        {
            "<leader>th",
            Utils.telescope("colorscheme", { enable_preview = true }),
            desc =
            "Colorscheme with preview"
        },
        {
            "<leader>ss",
            Utils.telescope("lsp_document_symbols", {
                symbols = {
                    "Class",
                    "Function",
                    "Method",
                    "Constructor",
                    "Interface",
                    "Module",
                    "Struct",
                    "Trait",
                    "Field",
                    "Property",
                },
            }),
            desc = "Goto Symbol",
        },
        { "<leader>ma", "<cmd>Telescope marks<CR>", desc = "Telescope bookmarks" },
        { "<leader>nf", "<cmd>Telescope notify<CR>", desc = "Telescope notifications" },
        {
            "<leader>sS",
            Utils.telescope("lsp_dynamic_workspace_symbols", {
                symbols = {
                    "Class",
                    "Function",
                    "Method",
                    "Constructor",
                    "Interface",
                    "Module",
                    "Struct",
                    "Trait",
                    "Field",
                    "Property",
                },
            }),
            desc = "Goto Symbol (Workspace)",
        },
    },
    opts = function()
        return {
            defaults = {
                vimgrep_arguments = { "rg", "-L", "--color=never", "--no-heading", "--with-filename", "--line-number",
                    "--column", "--smart-case" },
                prompt_prefix = "   ",
                selection_caret = " ",
                entry_prefix = "  ",
                -- initial_mode = "normal",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8
                    },
                    vertical = {
                        mirror = false
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120
                },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "node_modules" },
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                path_display = { "truncate" },
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                set_env = {
                    ["COLORTERM"] = "truecolor"
                }, -- default = nil,
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                mappings = {
                    n = {
                        ["q"] = require("telescope.actions").close
                    }
                }
            },

            extensions_list = { "projects", "notify" }
        }
    end,
    config = function(_, opts)
        local telescope = require "telescope"
        telescope.setup(opts)

        -- load extensions
        for _, ext in ipairs(opts.extensions_list) do
            telescope.load_extension(ext)
        end
    end
}
