local opt = vim.opt

opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.syntax = "enable"
opt.conceallevel = 0
opt.completeopt = { "menu", "menuone", "noselect" }
opt.hidden = true
opt.encoding = "utf-8"
opt.pumheight = 10
opt.fileencoding = "utf-8"
opt.cmdheight = 1
opt.wildmenu = true
-- opt.lazyredraw = true
opt.showmatch = true

opt.hlsearch = true
opt.incsearch = true

opt.shell = "fish"
opt.autochdir = true
opt.formatoptions = "cro"
opt.showtabline = 1
opt.background = "dark"

opt.clipboard = "unnamedplus"
opt.cursorline = true

opt.title = true
opt.wrap = true

opt.scrolloff = 8
opt.sidescrolloff = 8

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.smarttab = true
opt.autoindent = true

opt.fillchars = {
    eob = " "
}
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

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeout = true
opt.timeoutlen = 300
opt.undofile = true
opt.swapfile = false
opt.writebackup = false

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

opt.list = true
-- opt.listchars:append "space:⋅"
