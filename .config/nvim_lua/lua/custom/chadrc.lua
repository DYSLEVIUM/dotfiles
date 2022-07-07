-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "gruvbox",
  theme_toggle = { "gruvbox", "gruvbox_light" },
  italic_comments = true,
  statusline = {
    separator_style = "default",
  },
  transparency = true,
  hl_add = require "custom.highlights",
}

local override = require "custom.override"

M.options = {
   user = function()
    require("custom.options")
   end,
}

M.plugins = {
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },
  override = {
    ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
    ["L3MON4D3/LuaSnip"] = override.luasnip,
    ["hrsh7th/nvim-cmp"] = override.cmp
  },
  user = require "custom.plugins"
}

M.mappings = require "custom.mappings"

return M
