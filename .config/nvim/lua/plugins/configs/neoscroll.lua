return {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
        easing_function = "quadratic",
        hide_cursor = false,
    },
    config = function(_, opts)
        require("neoscroll").setup(opts)
    end,
}
