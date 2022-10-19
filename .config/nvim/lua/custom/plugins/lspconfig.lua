local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = {
	"bashls",
	"clangd",
	"ccls",
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
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- clangd specific overrides
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.semanticHighlighting = true
capabilities.offsetEncoding = "utf-16"

lspconfig["clangd"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlighting = true,
	},
})
