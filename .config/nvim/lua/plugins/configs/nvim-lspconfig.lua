return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
        {
            "folke/neoconf.nvim",
            cmd = "Neoconf",
            config = true,
        }
    },
    init = function()
        require("core.utils").lazy_load "nvim-lspconfig"
    end,
    config = function()
        local M = {}
        local Utils = require "core.utils"

        -- export on_attach & capabilities for custom lspconfigs

        M.on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            Utils.load_mappings("lspconfig", { buffer = bufnr })

            -- !changed
            if client.server_capabilities.signatureHelpProvider then
                require("core.utils").setup(client)
            end

            if not Utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
                client.server_capabilities.semanticTokensProvider = nil
            end
        end

        M.capabilities = vim.lsp.protocol.make_client_capabilities()

        M.capabilities.textDocument.completion.completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                },
            },
        }


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
            "cmake",
            "tailwindcss",
            "lua_ls",
            "gopls",
        }

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                on_attach = M.on_attach,
                capabilities = M.capabilities,
            })
        end

        lspconfig.lua_ls.setup {
            on_attach = M.on_attach,
            capabilities = M.capabilities,

            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                },
            },
        }

        -- clangd specific overrides
        local clangd_capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)
        clangd_capabilities.textDocument.semanticHighlighting = true
        clangd_capabilities.offsetEncoding = "utf-16"

        lspconfig.clangd.setup({
            on_attach = M.on_attach,
            capabilities = clangd_capabilities,
            init_options = {
                clangdFileStatus = true,
                usePlaceholders = true,
                completeUnimported = true,
                semanticHighlighting = true,
            },
        })

        vim.diagnostic.config {
            virtual_text = {
                prefix = "●", -- Could be '■', '▎', 'x'
            },
            -- virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = true,
        }

        return M
    end,
}
