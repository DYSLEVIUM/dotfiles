local utils = require "core.utils"

return {
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        topdelete = { text = "" },
        changedelete = { text = "~" },
        untracked = { text = "▎" },
    },
    on_attach = function(bufnr)
        utils.load_mappings("gitsigns", { buffer = bufnr })
    end,
}
