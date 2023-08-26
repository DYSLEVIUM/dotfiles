return {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = {
        open_cmd = "noswapfile vnew",
        live_update = true
    },
    keys = {
        { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
}
