return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<leader>fe",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = require("core.utils").get_root() })
            end,
            desc = "Explorer NeoTree (root dir)",
        },
        {
            "<leader>fE",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
            end,
            desc = "Explorer NeoTree (cwd)",
        },
        { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
        { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("neo-tree")
            end
        end
    end,
    opts = {
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = {
                enabled = true
            },
            use_libuv_file_watcher = true,
        },
        window = {
            width = 30,
            mappings = {
                ["<space>"] = "none",
            },
        },
        default_component_configs = {
            indent = {
                padding = 0,
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            name = {
                trailing_slash = true,
            },
            icon = {
                folder_empty = "󰜌",
                folder_empty_open = "󰜌",
            },
            git_status = {
                symbols = {
                    renamed = "󰁕",
                    unstaged = "󰄱",
                },
            },
        },
    },
    config = function(_, opts)
        require("neo-tree").setup(opts)
        vim.api.nvim_create_autocmd("TermClose", {
            pattern = "*lazygit",
            callback = function()
                if package.loaded["neo-tree.sources.git_status"] then
                    require("neo-tree.sources.git_status").refresh()
                end
            end,
        })
    end,
}

-- ["<2-LeftMouse>"] = "open",
-- ["<cr>"] = "open",
-- ["<esc>"] = "cancel", -- close preview or floating neo-tree window
-- ["P"] = { "toggle_preview", config = { use_float = true } },
-- ["l"] = "focus_preview",
-- ["S"] = "open_split",
-- ["s"] = "open_vsplit",
-- -- ["S"] = "split_with_window_picker",
-- -- ["s"] = "vsplit_with_window_picker",
-- ["t"] = "open_tabnew",
-- -- ["<cr>"] = "open_drop",
-- -- ["t"] = "open_tab_drop",
-- ["w"] = "open_with_window_picker",
-- --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
-- ["C"] = "close_node",
-- -- ['C'] = 'close_all_subnodes',
-- ["z"] = "close_all_nodes",
-- --["Z"] = "expand_all_nodes",
-- ["a"] = { 
--   "add",
--   -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
--   -- some commands may take optional config options, see `:h neo-tree-mappings` for details
--   config = {
--     show_path = "none" -- "none", "relative", "absolute"
--   }
-- },
-- ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
-- ["d"] = "delete",
-- ["r"] = "rename",
-- ["y"] = "copy_to_clipboard",
-- ["x"] = "cut_to_clipboard",
-- ["p"] = "paste_from_clipboard",
-- ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
-- -- ["c"] = {
-- --  "copy",
-- --  config = {
-- --    show_path = "none" -- "none", "relative", "absolute"
-- --  }
-- --}
-- ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
-- ["q"] = "close_window",
-- ["R"] = "refresh",
-- ["?"] = "show_help",
-- ["<"] = "prev_source",
-- [">"] = "next_source",
-- ["i"] = "show_file_details",
--
-- mappings = {
-- ["<bs>"] = "navigate_up",
-- ["."] = "set_root",
-- ["H"] = "toggle_hidden",
-- ["/"] = "fuzzy_finder",
-- ["D"] = "fuzzy_finder_directory",
-- ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
-- -- ["D"] = "fuzzy_sorter_directory",
-- ["f"] = "filter_on_submit",
-- ["<c-x>"] = "clear_filter",
-- ["[g"] = "prev_git_modified",
-- ["]g"] = "next_git_modified",
-- ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
-- ["oc"] = { "order_by_created", nowait = false },
-- ["od"] = { "order_by_diagnostics", nowait = false },
-- ["om"] = { "order_by_modified", nowait = false },
-- ["on"] = { "order_by_name", nowait = false },
-- ["os"] = { "order_by_size", nowait = false },
-- ["ot"] = { "order_by_type", nowait = false },
-- },
-- fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
-- ["<down>"] = "move_cursor_down",
-- ["<C-n>"] = "move_cursor_down",
-- ["<up>"] = "move_cursor_up",
-- ["<C-p>"] = "move_cursor_up",
-- },
--
--  mappings = {
-- ["bd"] = "buffer_delete",
-- ["<bs>"] = "navigate_up",
-- ["."] = "set_root",
-- ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
-- ["oc"] = { "order_by_created", nowait = false },
-- ["od"] = { "order_by_diagnostics", nowait = false },
-- ["om"] = { "order_by_modified", nowait = false },
-- ["on"] = { "order_by_name", nowait = false },
-- ["os"] = { "order_by_size", nowait = false },
-- ["ot"] = { "order_by_type", nowait = false },
-- }
