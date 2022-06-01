local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone", "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "windwp/nvim-autopairs"
  use "kyazdani42/nvim-web-devicons"
  use "ryanoasis/vim-devicons"
  use "mhinz/vim-startify"
  use "nvim-lualine/lualine.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "numToStr/Comment.nvim"
  use "tpope/vim-surround"
  use "phaazon/hop.nvim"
  use "justinmk/vim-sneak"
  use "terryma/vim-multiple-cursors"
  use "kyazdani42/nvim-tree.lua"
  use "akinsho/toggleterm.nvim"
  use { "akinsho/bufferline.nvim", tag = "v2.*" }
  use "moll/vim-bbye"
  --use "tamago324/lir.nvim"
  --use "ahmedkhalf/project.nvim"
  --use "lewis6991/impatient.nvim"
  --use "lukas-reineke/indent-blankline.nvim"
  --use "goolord/alpha-nvim"
  --use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  --use "folke/which-key.nvim"
  --use "unblevable/quick-scope"
  --use "andymass/vim-matchup"
  --use "nacro90/numb.nvim"
  --use "monaqa/dial.nvim"
  --use "norcalli/nvim-colorizer.lua"
  --use "windwp/nvim-spectre"
  --use "folke/zen-mode.nvim"
  --use "karb94/neoscroll.nvim"
  --use "folke/todo-comments.nvim"
  --use "kevinhwang91/nvim-bqf"
  --use "ThePrimeagen/harpoon"
  ---- use "lunarvim/vim-solidity"
  --use "tpope/vim-repeat"
  ---- use "Shatur/neovim-session-manager"
  --use "rcarriga/nvim-notify"
  --use "tversteeg/registers.nvim"
  ---- use "metakirby5/codi.vim"
  --use { "nyngwang/NeoZoom.lua", branch = "neo-zoom-original" }
  --use { "christianchiarulli/nvim-gps", branch = "text_hl" }
  --use { "michaelb/sniprun", run = "bash ./install.sh" }
  --use {

  --  "iamcco/markdown-preview.nvim",
  --  run = "cd app && npm install",
  --  ft = "markdown",
  --}
  --use {
  --  "christianchiarulli/JABS.nvim",
  --  requires = { "kyazdani42/nvim-web-devicons" }, --optional
  --}

  --use {
  --  "ghillb/cybu.nvim",
  --  branch = "v1.x", -- won't receive breaking changes
  --  -- branch = "main", -- timely updates
  --  requires = { "kyazdani42/nvim-web-devicons" }, --optional
  --}

  ---- Colorschemes
  use 'ellisonleao/gruvbox.nvim'
  use 'navarasu/onedark.nvim'
  use 'tiagovla/tokyodark.nvim'

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-emoji"
  use "lukas-reineke/cmp-rg"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  --use "filipdutescu/renamer.nvim"
  --use "simrat39/symbols-outline.nvim"
  --use "ray-x/lsp_signature.nvim"
  --use "b0o/SchemaStore.nvim"
  --use {
  --  "folke/trouble.nvim",
  --  cmd = "TroubleToggle",
  --}
  use "github/copilot.vim"
  --use "RRethy/vim-illuminate"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "windwp/nvim-ts-autotag"
  --use "mizlan/iswap.nvim"

  -- Git
  use 'tpope/vim-fugitive' -- git integration
  use 'junegunn/gv.vim' -- commit history
  use "lewis6991/gitsigns.nvim"
  --use "f-person/git-blame.nvim"
  --use "ruifm/gitlinker.nvim"
  --use "mattn/vim-gist"
  --use "mattn/webapi-vim"
  --use "https://github.com/rhysd/conflict-marker.vim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
