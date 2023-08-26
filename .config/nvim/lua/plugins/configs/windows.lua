return {
    "anuvyklack/windows.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim"
    },
    keys = {
        {
            "<C-w>m",
            mode = "n",
            "<Cmd>WindowsMaximize<CR>",
            desc = "Maximize Window Vertically"
        },
        {
            "<C-w>_",
            mode = "n",
            "<Cmd>WindowsMaximizeVertically<CR>",
            desc = "Maximize Window Vertically"
        },
        {
            "<C-w>|",
            mode = "n",
            "<Cmd>WindowsMaximizeHorizontally<CR>",
            desc = "Maximize Window Horizontally"
        },
        {
            "<C-w>=",
            mode = "n",
            "<Cmd>WindowsEqualize<CR>",
            desc = "Equalize Windows"
        },
    },
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require('windows').setup()
    end
}
