return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", },
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
        local icons = require("core.icons").icons
        local Utils = require("core.utils")
        local lazy_status = require("lazy.status")

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
                    {
                        function() return require("nvim-navic").get_location() end,
                        cond = function()
                            return package.loaded["nvim-navic"] and
                                require("nvim-navic").is_available()
                        end,
                    },
                },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#FE8019" },
                    },
                    {
                        function() return require("noice").api.status.command.get() end,
                        cond = function()
                            return package.loaded["noice"] and
                                require("noice").api.status.command.has()
                        end,
                        color = Utils.fg("Statement"),
                    },
                    {
                        function() return require("noice").api.status.mode.get() end,
                        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        color = Utils.fg("Constant"),
                    },
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
}
