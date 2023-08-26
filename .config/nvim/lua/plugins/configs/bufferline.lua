return {
    "akinsho/bufferline.nvim",
    event = { "BufNewFile", "BufEnter" },
    dependencies = { "nvim-tree/nvim-web-devicons", },
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        { "<tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
        { "<S-tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previouis tab" },
    },
    opts = {
        options = {
            separator_style = "thin",
            hover = {
                enabled = true,
                delay = 200,
                reveal = { 'close' }
            },
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            diagnostics_indicator = function(_, _, diag)
                local icons = require("core.icons").icons.diagnostics
                local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                    .. (diag.warning and icons.Warn .. diag.warning or "")
                return vim.trim(ret)
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    },
}
