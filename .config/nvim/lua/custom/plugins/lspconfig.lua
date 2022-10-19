local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

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

local init_options = {}
for _, lsp in ipairs(servers) do
  if lsp == "clangd" then
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    capabilities.textDocument.semanticHighlighting = true
    capabilities.offsetEncoding = "utf-16"

    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    }
  end
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = init_options,
  }
end
