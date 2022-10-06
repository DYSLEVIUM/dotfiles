return {
  ["goolord/alpha-nvim"] = {
    disable = false,
  },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        "sqlls",
        "yamlfmt",
        "yaml-language-server",
        "yamllint",
        "vim-language-server",
        "solidity",
        "terraform-ls",
        "sqlfluff",
        "tailwindcss-language-server",
        "sql-formatter",
        "solidity-ls",
        "ltex-ls",
        "python-lsp-server",
        "prisma-language-server",
        "pylint",
        "pyright",
        "prettierd",
        "prettier",
        "markdownlint",
        "graphql-language-service-cli",
        "grammarly-languageserver",
        "gitlint",
        "eslint_d",
        "eslint-lsp",
        "cmakelang",
        "cpptools",
        "editorconfig-checker",
        "diagnostic-languageserver",
        "dockerfile-language-server",
        "clangd",
        "cpplint",
        "cmake-language-server",
        "clang-format",
        "awk-language-server",
        "deno",
        "lua-language-server",
        "typescript-language-server",
        "css-lsp",
        "json-lsp",
        "stylua",
        "html-lsp",
        "emmet-ls",
        "shellcheck",
      },
    },
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["windwp/nvim-ts-autotag"] = {
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "markdown",
      "handlebars",
      "hbs",
    },
    skip_tags = {
      "br",
      "embed",
      "hr",
      "img",
      "input",
      "link",
      "meta",
    },
    after = "nvim-treesitter",
    config = function()
      local present, autotag = pcall(require, "nvim-ts-autotag")

      if present then
        autotag.setup()
      end
    end,
  },

  ["tpope/vim-surround"] = {},

  ["justinmk/vim-sneak"] = {},

  ["phaazon/hop.nvim"] = {
    branch = "v1",
    config = function()
      require("hop").setup {
        keys = "etovxqpdygfblzhckisuran",
      }
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "css",
        "fish",
        "go",
        "graphql",
        "help",
        "html",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "latex",
        "llvm",
        "lua",
        "make",
        "markdown",
        "prisma",
        "python",
        "regex",
        "rust",
        "scss",
        "solidity",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
      },
    },
  },

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = {
      sort_by = "name",
      view = {
        hide_root_folder = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",

        indent_markers = {
          enable = true,
        },

        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },

  ["hrsh7th/nvim-cmp"] = {
    override_options = function()
      local present, cmp = pcall(require, "cmp")

      if not present then
        return
      end

      return {
        mapping = {
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          },
        },
      }
    end,
  },

  ["NvChad/ui"] = {
    override_options = {
      vim.diagnostic.config {
        virtual_text = {
          prefix = "",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
      },
    },
  },

  ["folke/which-key.nvim"] = {
    disable = false,
  },
}
