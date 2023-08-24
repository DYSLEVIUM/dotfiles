local Utils = require("core.utils")

local default_plugins = {
    -- ui
    { "nvim-lua/plenary.nvim" },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent_mode = true,
        },
        config = function(_, opts)
            require("gruvbox").setup(opts)
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    { "nvim-tree/nvim-web-devicons", event = "VeryLazy", },
    {
        "nvim-neo-tree/neo-tree.nvim",
        event = "VeryLazy",
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
                mappings = {
                    ["<space>"] = "none",
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
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
    },
    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim"
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require('windows').setup()
        end
    },

    -- navigation
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "mg979/vim-visual-multi",
        event = "VeryLazy",
    },
    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        opts = {
            easing_function = "quadratic",
            hide_cursor = false,
        },
        config = function(_, opts)
            require("neoscroll").setup(opts)
        end,
    },

    {
        "sudormrfbin/cheatsheet.nvim",
        event = "VeryLazy",
        dependencies = {
            {'nvim-telescope/telescope.nvim'},
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
        },
    },
    {
        "folke/neoconf.nvim",
        event = "VeryLazy",
        cmd = "Neoconf",
        config = false,
        dependencies = {
            "nvim-lspconfig"
        }
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        opts = function()
        local nls = require("null-ls")
        return {
          root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
          sources = {
            nls.builtins.formatting.fish_indent,
            nls.builtins.diagnostics.fish,
            nls.builtins.formatting.stylua,
            nls.builtins.formatting.shfmt,
            -- nls.builtins.diagnostics.flake8,
          },
        }
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy"
    },
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    -- lsp stuff
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        opts = function()
            return require "plugins.configs.mason"
        end,
        config = function(_, opts)
            require("mason").setup(opts)

            -- custom cmd to install all mason binaries listed
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end, {})

            vim.g.mason_binaries_list = opts.ensure_installed
        end,
    },
    {
        "nvim-pack/nvim-spectre",
        event = "VeryLazy",
        cmd = "Spectre",
        opts = {
            open_cmd = "noswapfile vnew",
            live_update = true
        },
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "S",
                mode = { "n", "o", "x" },
                function() require("flash").treesitter() end,
                desc =
                "Flash Treesitter"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote Flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
            {
                "<c-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc =
                "Toggle Flash Search"
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        cmd = "Telescope",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        -- keys = {
        --     { "<leader>,",       "<cmd>Telescope buffers show_all_buffers=true<cr>",    desc = "Switch Buffer" },
        --     { "<leader>/",       Utils.telescope("live_grep"),                          desc = "Grep (root dir)" },
        --     { "<leader>:",       "<cmd>Telescope command_history<cr>",                  desc = "Command History" },
        --     { "<leader><space>", Utils.telescope("files"),                              desc = "Find Files (root dir)" },
        --     -- find
        --     { "<leader>fb",      "<cmd>Telescope buffers<cr>",                          desc = "Buffers" },
        --     { "<leader>ff",      Utils.telescope("files"),                              desc = "Find Files (root dir)" },
        --     { "<leader>fF",      Utils.telescope("files", { cwd = false }),             desc = "Find Files (cwd)" },
        --     { "<leader>fr",      "<cmd>Telescope oldfiles<cr>",                         desc = "Recent" },
        --     { "<leader>fR",      Utils.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        --     -- git
        --     { "<leader>gc",      "<cmd>Telescope git_commits<CR>",                      desc = "commits" },
        --     { "<leader>gs",      "<cmd>Telescope git_status<CR>",                       desc = "status" },
        --     -- search
        --     { "<leader>sa",      "<cmd>Telescope autocommands<cr>",                     desc = "Auto Commands" },
        --     { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",        desc = "Buffer" },
        --     { "<leader>sc",      "<cmd>Telescope command_history<cr>",                  desc = "Command History" },
        --     { "<leader>sC",      "<cmd>Telescope commands<cr>",                         desc = "Commands" },
        --     { "<leader>sd",      "<cmd>Telescope diagnostics bufnr=0<cr>",              desc = "Document diagnostics" },
        --     { "<leader>sD",      "<cmd>Telescope diagnostics<cr>",                      desc = "Workspace diagnostics" },
        --     { "<leader>sg",      Utils.telescope("live_grep"),                          desc = "Grep (root dir)" },
        --     { "<leader>sG",      Utils.telescope("live_grep", { cwd = false }),         desc = "Grep (cwd)" },
        --     { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                        desc = "Help Pages" },
        --     {
        --         "<leader>sH",
        --         "<cmd>Telescope highlights<cr>",
        --         desc =
        --         "Search Highlight Groups"
        --     },
        --     { "<leader>sk", "<cmd>Telescope keymaps<cr>",                    desc = "Key Maps" },
        --     { "<leader>sM", "<cmd>Telescope man_pages<cr>",                  desc = "Man Pages" },
        --     { "<leader>sm", "<cmd>Telescope marks<cr>",                      desc = "Jump to Mark" },
        --     { "<leader>so", "<cmd>Telescope vim_options<cr>",                desc = "Options" },
        --     { "<leader>sR", "<cmd>Telescope resume<cr>",                     desc = "Resume" },
        --     { "<leader>sw", Utils.telescope("grep_string"),                  desc = "Word (root dir)" },
        --     { "<leader>sW", Utils.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
        --     {
        --         "<leader>uC",
        --         Utils.telescope("colorscheme", { enable_preview = true }),
        --         desc =
        --         "Colorscheme with preview"
        --     },
        --     {
        --         "<leader>ss",
        --         Utils.telescope("lsp_document_symbols", {
        --             symbols = {
        --                 "Class",
        --                 "Function",
        --                 "Method",
        --                 "Constructor",
        --                 "Interface",
        --                 "Module",
        --                 "Struct",
        --                 "Trait",
        --                 "Field",
        --                 "Property",
        --             },
        --         }),
        --         desc = "Goto Symbol",
        --     },
        --     {
        --         "<leader>sS",
        --         Utils.telescope("lsp_dynamic_workspace_symbols", {
        --             symbols = {
        --                 "Class",
        --                 "Function",
        --                 "Method",
        --                 "Constructor",
        --                 "Interface",
        --                 "Module",
        --                 "Struct",
        --                 "Trait",
        --                 "Field",
        --                 "Property",
        --             },
        --         }),
        --         desc = "Goto Symbol (Workspace)",
        --     },
        -- },
        opts = function()
            return require "plugins.configs.telescope"
        end,
        init = function()
            require("core.utils").load_mappings "telescope"
        end,
        config = function(_, opts)
            local telescope = require "telescope"
            telescope.setup(opts)
    
            -- load extensions
            for _, ext in ipairs(opts.extensions_list) do
                telescope.load_extension(ext)
            end
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = "folke/flash.nvim",
        opts = function(_, opts)
            local function flash(prompt_bufnr)
                require("flash").jump({
                    pattern = "^",
                    label = { after = { 0, 0 } },
                    search = {
                        mode = "search",
                        exclude = {
                            function(win)
                                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                            end,
                        },
                    },
                    action = function(match)
                        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                        picker:set_selection(match.pos[1] - 1)
                    end,
                })
            end
            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
                mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
            defaults = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["gz"] = { name = "+surround" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+file/find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gh"] = { name = "+hunks" },
                ["<leader>q"] = { name = "+quit/session" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>u"] = { name = "+ui" },
                ["<leader>w"] = { name = "+windows" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
            },
        },
        init = function()
            require("core.utils").load_mappings "whichkey"
        end,
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = { "gitsigns.nvim" } }
                        end)
                    end
                end,
            })
        end,
        opts = function()
            return require("plugins.configs.gitsigns")
        end,
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]]", desc = "Next Reference" },
            { "[[", desc = "Prev Reference" },
        },
    },
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        cmd = { "TroubleToggle", "Trouble" },
        opts = {
            use_diagnostic_signs = true,
            action_keys = {
                close = { "q", "<esc>" },
                cancel = "<c-e>"
            }
        },
        event = "VeryLazy",
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<CR>",  desc = "Document Diagnostics" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous trouble/quickfix item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next trouble/quickfix item",
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        },
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n",          desc = "Comment toggle current block" },
            { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
        },
        init = function()
            Utils.load_mappings "comment"
        end,
        config = function(_, opts)
            require("Comment").setup(opts)
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        init = function()
            Utils.lazy_load "nvim-treesitter"
        end,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            return require "plugins.configs.treesitter"
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "echasnovski/mini.surround",
        event = "InsertEnter",
        keys = {
            { "gza", desc = "Add surrounding",                     mode = { "n", "v" } },
            { "gzd", desc = "Delete surrounding" },
            { "gzf", desc = "Find right surrounding" },
            { "gzF", desc = "Find left surrounding" },
            { "gzh", desc = "Highlight surrounding" },
            { "gzr", desc = "Replace surrounding" },
            { "gzn", desc = "Update `MiniSurround.config.n_lines`" },
        },
        opts = {
            mappings = {
                add = "gza",            -- Add surrounding in Normal and Visual modes
                delete = "gzd",         -- Delete surrounding
                find = "gzf",           -- Find surrounding (to the right)
                find_left = "gzF",      -- Find surrounding (to the left)
                highlight = "gzh",      -- Highlight surrounding
                replace = "gzr",        -- Replace surrounding
                update_n_lines = "gzn", -- Update `n_lines`
            },
        },
    },
    {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss all Notifications",
            },
        },
        opts = {
            timeout = 3000,
            background_colour = "#000000",
            max_height = function()
                return math.floor(vim.o.lines * 0.5)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.5)
            end,
        },
        init = function()
            -- when noice is not enabled, install notify on VeryLazy
            if not Utils.has("noice.nvim") then
                Utils.on_very_lazy(function()
                    vim.notify = require("notify")
                end)
            end
        end,
    },
    {
        "SmiteshP/nvim-navbuddy",
        event = "LspAttach",
        dependencies = {
          "SmiteshP/nvim-navic",
        },
        config = function()
          require("nvim-navbuddy").setup({
            icons = icons,
          })
        end,
        cmd = "Navbuddy",
    }, -- Outline symbols
--     {
--         "Bekaboo/dropbar.nvim",
--         event = { "LspAttach" },
--         opts = {
--           icons = {
--             kinds = {
--               symbols = icons,
--             },
--             ui = {
--               bar = {
--                 separator = "  ",
--               },
--             },
--           },
-- --          sources = {
-- --            path = {
-- --              relative_to = function(_)
-- --                local current_directory = vim.fn.expand('%:p:h')
-- --                local parent_directory = vim.fn.fnamemodify(current_directory, ':h')
-- --                return parent_directory
-- --              end
-- --            }
-- --          },
-- --          menu = {
-- --            win_confings = {
-- --              border = utils.border_status,
-- --            },
-- --          },
--         },
--     },
    {
        "petertriho/nvim-scrollbar",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
          require("scrollbar").setup({
            handle = {
                color = "#665C54",
            },
            marks = {
                Search = { color = "#FE8019" },
                Error = { color = "#FB4934" },
                Warn = { color = "#D65D0e" },
                Info = { color = "#458588" },
                Hint = { color = "#FABD2F" },
                Misc = { color = "#D3869B" },
            }
          })
          require("scrollbar.handlers.gitsigns").setup()
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
                },
            },
            presets = {
                -- bottom_search = true,
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
            },
            cmdline = {
                enabled = true,
                -- view = "cmdline_popup",
                view = "cmdline",
                format = {
                    conceal = true,
                    conceal = false,
                    -- cmdline = { pattern = "^:", icon = "", lang = "vim" },
                    cmdline = false,
                }
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = 5,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "single",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        },
        -- stylua: ignore
        keys = {
            {
                "<S-Enter>",
                function() require("noice").redirect(vim.fn.getcmdline()) end,
                mode = "c",
                desc =
                "Redirect Cmdline"
            },
            {
                "<leader>snl",
                function() require("noice").cmd("last") end,
                desc =
                "Noice Last Message"
            },
            {
                "<leader>snh",
                function() require("noice").cmd("history") end,
                desc =
                "Noice History"
            },
            {
                "<leader>sna",
                function() require("noice").cmd("all") end,
                desc =
                "Noice All"
            },
            {
                "<leader>snd",
                function() require("noice").cmd("dismiss") end,
                desc =
                "Dismiss All"
            },
            {
                "<c-f>",
                function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
                silent = true,
                expr = true,
                desc =
                "Scroll forward",
                mode = {
                    "i", "n", "s" }
            },
            {
                "<c-b>",
                function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
                silent = true,
                expr = true,
                desc =
                "Scroll backward",
                mode = {
                    "i", "n", "s" }
            },
        },
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        },
        opts = {
            options = {
                separator_style = "thin",
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' }
                },

                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    local icons = require("core.icons").icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = function()
            require("plugins.configs.blankline")
        end
        ,
    },
    {
        "SmiteshP/nvim-navic",
        event = "VeryLazy",
        init = function()
            vim.g.navic_silence = true
            Utils.on_attach(function(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        opts = {
            separator = " ",
            highlight = true,
            depth_limit = 5,
            icons = require("core.icons").icons.kinds,
        },
    },

    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } }
            }
        },
    },
    --     {
    --     "neovim/nvim-lspconfig",
    --     init = function()
    --         require("core.utils").lazy_load "nvim-lspconfig"
    --     end,
    --     config = function()
    --         require "plugins.configs.lspconfig"
    --     end,
    -- },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local icons = require("core.icons").icons

            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        {
                            "filetype",
                            icon_only = true,
                            separator = "",
                            padding = {
                                left = 1, right = 0 
                            }
                        },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                        -- stylua: ignore
                        {
                            function() return require("nvim-navic").get_location() end,
                            cond = function()
                                return package.loaded["nvim-navic"] and
                                    require("nvim-navic").is_available()
                            end,
                        },
                    },
                    lualine_x = {
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.command.get() end,
                            cond = function()
                                return package.loaded["noice"] and
                                    require("noice").api.status.command.has()
                            end,
                            color = Utils.fg("Statement"),
                        },
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                            color = Utils.fg("Constant"),
                        },
                        -- stylua: ignore
                        {
                            function() return "  " .. require("dap").status() end,
                            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                            color = Utils.fg("Debug"),
                        },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = Utils.fg("Special")
                        },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                        },
                    },
                    lualine_y = {
                        { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        -- function()
                        --     return " " .. os.date("%R")
                        -- end,
                    },
                },
                extensions = { "neo-tree", "lazy" },
            }
        end,
        config = function(_, opts)
            require("lualine").setup(opts)
        end
    },
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
    },
    {
        'glepnir/dashboard-nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope.nvim"
        },
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    -- week_header = {
                    --     enable = true,
                    -- },
                    header = {
                        [[                                                    ]],
                        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
                        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
                        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
                        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
                        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
                        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
                        [[                                                    ]],
                    },
                    shortcut = {
                        {
                            icon = '󰊳 ',
                            desc = 'Update',
                            action = 'Lazy update',
                            key = 'u'
                        },
                        {
                            icon = ' ',
                            desc = 'Find Files',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            icon = ' ',
                            desc = 'Search Text',
                            action = 'Telescope live_grep',
                            key = 'd',
                        },
                        {
                            icon = ' ',
                            desc = 'Recent Projects',
                            action = 'Telescope projects',
                            key = 'p',
                        },
                        {
                            icon = ' ',
                            desc = 'Recent Files',
                            action = 'Telescope oldfiles',
                            key = 'b',
                        },
                    },
                },
            }
        end,
    },
    {
        'edluffy/specs.nvim',
        event = "VeryLazy",
        opts = function()
            return {
                popup = {
                    delay_ms = 100, -- delay before popup displays
                    inc_ms = 10,    -- time increments used for fade/resize effects
                    blend = 30,     -- starting blend, between 0-100 (fully transparent), see :h winblend
                    width = 50,
                    winhl = "PMenu",
                    fader = require('specs').linear_fader,
                    resizer = require('specs').shrink_resizer
                },
            }
        end,
        config = function(_, opts)
            require("specs").setup(opts)
        end
    },
    {
        'akinsho/toggleterm.nvim',
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            size = 10,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (not jit.os:find("Windows"))
                    and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
                    or nil,
                dependencies = "rafamadriz/friendly-snippets",
                opts = {
                    history = true,
                    delete_check_events = "TextChanged",
                    updateevents = "TextChanged,TextChangedI"
                },
                -- stylua: ignore
                keys = {
                    {
                        "<tab>",
                        function()
                            return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                        end,
                        expr = true,
                        silent = true,
                        mode = "i",
                    },
                    { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
                    { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
                },
                config = function(_, opts)
                    require("plugins.configs.luasnip")(opts)
                end
            },
            -- autopairing of (){}[] etc
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)
                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },
            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
        opts = function()
            return require "plugins.configs.cmp"
        end,
    },
    { "f-person/git-blame.nvim", },
}

local config = Utils.load_config()

require("lazy").setup(default_plugins, config.lazy)
