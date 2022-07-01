return {
  ["goolord/alpha-nvim"] = {
    disable = false
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

   ["windwp/nvim-ts-autotag"] = {
      filetypes = {
        'html',
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'svelte',
        'vue',
        'tsx',
        'jsx',
        'rescript',
        'markdown',
        'handlebars',
        'hbs'
      },
      skip_tags = {
        'br',
        'embed',
        'hr',
        'img',
        'input',
        'link',
        'meta',
      },
      after = "nvim-treesitter",
      config = function()
         local present, autotag = pcall(require, "nvim-ts-autotag")

         if present then
            autotag.setup()
         end
      end,
   },
}
