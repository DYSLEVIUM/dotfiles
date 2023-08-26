return {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
        return {
            ensure_installed = { "awk-language-server", "bash-language-server", "black", "autopep8", "cpptools","clang-format", "clangd",
                "cmake-language-server", "cmakelang", "codespell", "css-lsp",
                "cssmodules-language-server", "docker-compose-language-service", "dockerfile-language-server",
                "emmet-language-server", "eslint-lsp", "eslint_d",
                "graphql-language-service-cli", "helm-ls", "html-lsp",
                "lua-language-server",
                "prettierd", "python-lsp-server",
                "shellcheck", "tailwindcss-language-server", "typescript-language-server", "yaml-language-server", }, -- not an option from mason.nvim

            PATH = "skip",

            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = "󰄳 ",
                    package_uninstalled = " 󰚌"
                },

                keymaps = {
                    toggle_server_expand = "<CR>",
                    install_server = "i",
                    update_server = "u",
                    check_server_version = "c",
                    update_all_servers = "U",
                    check_outdated_servers = "C",
                    uninstall_server = "X",
                    cancel_installation = "<C-c>"
                }
            },

            max_concurrent_installers = 10
        }
    end,
    config = function(_, opts)
        require("mason").setup(opts)

        -- custom cmd to install all mason binaries listed
        vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end, {})

        vim.g.mason_binaries_list = opts.ensure_installed
    end,
}
