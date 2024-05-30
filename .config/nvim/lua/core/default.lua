local M = {}

M.ui = {
    transparency = false,
    lsp_semantic_tokens = false,

    -- cmp themeing
    cmp = {
        icons = true,
        lspkind_text = true,
        style = "default",           -- default/flat_light/flat_dark/atom/atom_colored
        border_color = "grey_fg",    -- only applicable for "default" style, use color names from base30 variables
        selected_item_bg = "simple", -- colored / simple
    },

    telescope = { style = "borderless" }, -- borderless / bordered

    -- lazyload it when there are 1+ buffers
    tabufline = {
        show_numbers = false,
        enabled = true,
        lazyload = true,
        overriden_modules = nil,
    },

    cheatsheet = { theme = "grid" }, -- simple/grid

    lsp = {
        -- show function signatures i.e args as you type
        signature = {
            disabled = false,
            silent = true, -- silences 'no signature help available' message from appearing
        },
    },
}

M.mappings = require "core.mappings"

vim.cmd([[autocmd ColorScheme * highlight SignColumn guibg=NONE]])

return M
