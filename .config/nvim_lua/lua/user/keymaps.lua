local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize with arrows
keymap("n", "<C-Up>", ":rsize +2<Cr>", opts)
keymap("n", "<C-Down>", ":resize -2<Cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<Cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<Cr>", opts)

-- move text up and down
keymap("n", "<A-j>", ":m .+1<Cr>==", opts)
keymap("n", "<A-k>", ":m .-2<Cr>==", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<Cr>==gi", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<Cr>==gi", opts)
keymap("v", "<A-j>", ":m .+1<Cr>==", opts)
keymap("v", "<A-k>", ":m .-2<Cr>==", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- hold the value, while pasting continuously
keymap("v", "p", '"_dP', opts)

-- press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- naviagate buffers
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- custom
-- vim-bookmarks
keymap("n", "<Leader>b", ":BookmarkToggle<Cr>", opts);
keymap("n", "<Leader>i", ":BookmarkAnnotate<Cr>", opts);

-- telescope
keymap("n", ";f", "<Cmd>lua require('telescope.builtin').find_files()<Cr>", opts);
keymap("n", ";r", "<Cmd>lua require('telescope.builtin').live_grep()<Cr>", opts);
keymap("n", "\\", "<Cmd>lua require('telescope.builtin').buffers()<Cr>", opts);
keymap("n", ";h", "<Cmd>lua require('telescope.builtin').help_tags()<Cr>", opts);

-- telescope-browser
keymap("n", "<Leader>fb", "<Cmd>lua require('telescope').extensions.file_browser.file_browser()<Cr>", opts);

-- hop
vim.api.nvim_set_keymap("", "s", ":HopChar2<cr>", { silent = true })
vim.api.nvim_set_keymap("", "S", ":HopWord<cr>", { silent = true })

-- nvim-tree
keymap("n", "<Leader>e", ":NvimTreeToggle<Cr>", opts);

-- lspsaga
-- lsp provider to find the cursor word definition and reference
keymap("n", "gh", "<Cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts);

-- show hover doc
keymap("n", "K", "<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts);

-- scroll down hover doc or scroll in definition preview
keymap("n", "<C-f>", "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts);
-- scroll up hover doc
keymap("n", "<C-b>", "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts);

-- show signature help
keymap("n", "gs", "<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts);

-- rename
keymap("n", "gr", "<Cmd>lua require('lspsaga.rename').rename()<CR>", opts);

-- preview definition
keymap("n", "gd", "<Cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts);
