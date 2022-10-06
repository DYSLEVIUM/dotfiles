require "custom.options"

vim.g.luasnippets_path = "./lua/custom/snippets"

vim.diagnostic.config {
  -- virtual_text = {
  --   prefix = "",
  -- },
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
}
