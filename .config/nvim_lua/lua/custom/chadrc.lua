n example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "gruvbox",
  theme_toggle = { "gruvbox", "onedark" },
  statusline = {
    separator_style = "arrow",
  },
  transparency = false,
}

local override = require "custom.override"

M.plugins = {
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },
  override = {
    ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
  },
  user = require "custom.plugins"
}

M.mappings = require "custom.mappings"

return M
