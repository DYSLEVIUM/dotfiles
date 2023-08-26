local Utils = require("core.utils")

return {
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
        vim.opt.termguicolors = true
        -- when noice is not enabled, install notify on VeryLazy
        if not Utils.has("noice.nvim") then
            Utils.on_very_lazy(function()
                vim.notify = require("notify")
            end)
        end
    end,
}
