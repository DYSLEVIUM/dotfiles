return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = function ()
        local transparency = require("core.utils").load_config().ui.transparency

        return {
            transparent_mode = transparency,
            contrast = "hard",
        }
    end,
    config = function(_, opts)
        require("gruvbox").setup(opts)
        vim.cmd([[colorscheme gruvbox]])
    end,
}
