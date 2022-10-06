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
  transparency = false,
  hl_add = require "custom.highlights",
}

M.plugins = require "custom.plugins"

M.mappings = require "custom.mappings"

return M
