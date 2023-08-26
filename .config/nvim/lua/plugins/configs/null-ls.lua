return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    dependencies = { "mason.nvim", "nvim-lua/plenary.nvim" },
    opts = function()
        local nls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        return {
          root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr=bufnr })
                        end
                    })
                end
            end,
          sources = {
            nls.builtins.diagnostics.fish,
            nls.builtins.diagnostics.checkmake,
            nls.builtins.diagnostics.clang_check,
            nls.builtins.diagnostics.cmake_lint,
            nls.builtins.diagnostics.cppcheck,
            nls.builtins.diagnostics.dotenv_linter,
            nls.builtins.diagnostics.flake8,
            nls.builtins.diagnostics.golangci_lint,
            nls.builtins.diagnostics.jsonlint,
            nls.builtins.diagnostics.ktlint,
            nls.builtins.diagnostics.markdownlint,
            nls.builtins.diagnostics.markdownlint_cli2,
            nls.builtins.diagnostics.protoc_gen_lint,
            nls.builtins.diagnostics.protolint,
            nls.builtins.diagnostics.shellcheck,
            nls.builtins.diagnostics.sqlfluff.with({
                extra_args = { "--dialect", "postgres" }, -- change to your dialect
            }),
            nls.builtins.diagnostics.staticcheck,
            nls.builtins.diagnostics.stylelint,
            nls.builtins.diagnostics.terraform_validate,
            nls.builtins.diagnostics.textidote,
            nls.builtins.diagnostics.tfsec,
            nls.builtins.diagnostics.tidy,
            nls.builtins.diagnostics.todo_comments,
            nls.builtins.diagnostics.tsc,
            nls.builtins.diagnostics.vint,
            nls.builtins.diagnostics.yamllint,

            nls.builtins.formatting.autoflake,
            nls.builtins.formatting.autopep8,
            nls.builtins.formatting.black,
            nls.builtins.formatting.clang_format,
            nls.builtins.formatting.cmake_format,
            nls.builtins.formatting.gofmt,
            nls.builtins.formatting.goimports,
            nls.builtins.formatting.goimports_reviser,
            nls.builtins.formatting.jq,
            nls.builtins.formatting.nginx_beautifier,
            nls.builtins.formatting.prettier_d_slim,
            nls.builtins.formatting.prettier_eslint,
            nls.builtins.formatting.prismaFmt,
            nls.builtins.formatting.protolint,
            nls.builtins.formatting.rustfmt,
            nls.builtins.formatting.rustywind,
            nls.builtins.formatting.sqlfmt,
            nls.builtins.formatting.standardts,
            nls.builtins.formatting.stylelint,
            nls.builtins.formatting.terrafmt,
            nls.builtins.formatting.terraform_fmt,
            nls.builtins.formatting.tidy,
            nls.builtins.formatting.yamlfix,
            nls.builtins.formatting.yamlfmt,
            nls.builtins.formatting.fish_indent,
            nls.builtins.formatting.stylua,
            nls.builtins.formatting.shfmt,
            nls.builtins.formatting.eslint_d,
          },
        }
    end,
}
