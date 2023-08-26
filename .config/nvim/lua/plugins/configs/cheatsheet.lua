-- Hit <leader>? to invoke cheatsheet telescope
return {
    "sudormrfbin/cheatsheet.nvim",
    event = "VeryLazy",
    dependencies = {
        {'nvim-telescope/telescope.nvim'},
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
    },
}
