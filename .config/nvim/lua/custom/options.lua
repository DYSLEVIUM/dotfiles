local opt = vim.opt

opt.syntax = "enable"
opt.conceallevel = 0
opt.completeopt = { "menu", "menuone", "noselect" }
opt.hidden = true
opt.encoding = "utf-8"
opt.pumheight = 10
opt.fileencoding = "utf-8"
opt.cmdheight = 1
opt.wildmenu = true
opt.lazyredraw = true
opt.showmatch = true

opt.hlsearch = true
opt.incsearch = true

opt.background = "dark"
opt.showtabline = 1
opt.timeoutlen = 500
opt.formatoptions = "cro"
opt.autochdir = true
opt.shell = "fish"
opt.showcmd = true

opt.showmode = false

opt.title = true
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.wrap = true

opt.scrolloff = 8
opt.sidescrolloff = 8

-- Indenting
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.smarttab = true
opt.tabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 1
opt.ruler = true
opt.relativenumber = true

-- disable nvim intro
opt.shortmess:append "sI"

-- sign column width is a mulptile of 2
opt.signcolumn = "yes:1"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.swapfile = false
opt.writebackup = false

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
