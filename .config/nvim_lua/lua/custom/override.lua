-- overriding default plugin configs!

local M = {}

M.treesitter = {
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
     "yaml"
   },
}

M.nvimtree = {
   git = {
      enable = true,
   },

   renderer = {
      highlight_git = true,
      icons = {
         show = {
            git = true,
         },
      },
   },
}

M.luasnip = function()
  local present, luasnip = pcall(require, "luasnip")

  if not present then
    return
  end

    require("luasnip.loaders.from_vscode").lazy_load({ paths = "./lua/custom/snippets" })
end

M.cmp = function()
  local present, cmp = pcall(require, "cmp")

  if not present then
    return
  end

  return {
    mapping = {
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Insert,
         select = true,
      },
    }
  }
end

return M
