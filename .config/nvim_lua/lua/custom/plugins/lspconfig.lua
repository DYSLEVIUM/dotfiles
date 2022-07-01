local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   local servers = {
    "bashls",
    "clangd",
    "cssls",
    "cssmodules_ls",
    "emmet_ls",
    "jsonls",
    "html",
    "dockerls",
    "dotls",
    "sqlls",
    "eslint",
    "graphql",
    "tsserver",
    "pyright",
    "yamlls",
    "bashls",
    "cmake",
    "tailwindcss",
    "sumneko_lua",
    "ltex",
    "gopls",
  }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
      }
   end
end

return M
