return {
    "folke/flash.nvim",
    vscode = true,
    keys = {
        {
            "<leader><S-f>s",
            mode = { "n", "x", "o" },
            function() require("flash").jump() end,
            desc = "Flash"
        },
        {
            "<leader><S-f>S",
            mode = { "n", "o", "x" },
            function() require("flash").treesitter() end,
            desc = "Flash Treesitter"
        },
        {
            "<leader><S-f>r",
            mode = "o",
            function() require("flash").remote() end,
            desc = "Remote Flash"
        },
        {
            "<leader><S-f>R",
            mode = { "o", "x" },
            function() require("flash").treesitter_search() end,
            desc = "Treesitter Search"
        },
        {
            "<leader><S-f><C-s>",
            mode = { "c" },
            function() require("flash").toggle() end,
            desc = "Toggle Flash Search"
        },
    },
}
