local Utils = require("core.utils")

return {
    "SmiteshP/nvim-navic",
    dependencies = {
        "neovim/nvim-lspconfig",
    },
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
}
