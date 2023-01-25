local M = {}

M.resize = {
	n = {
		["<C-Up>"] = { "<cmd> resize +2<cr>", "increase horizontal window size" },
		["<C-Down>"] = { "<cmd> resize -2<cr>", "decrease horizontal window size" },
		["<C-Left>"] = { "<cmd> vertical resize -2<cr>", "decrease vertical window size" },
		["<C-Right>"] = { "<cmd> vertical resize +2<cr>", "increase vertical window size" },
	},
}

M.qualityOfLife = {
	n = {
		["<C-a>"] = { "gg<S-v>G", "select all" },
		["<A-k>"] = { ":m .-2<CR>", "move line up" },
		["<A-j>"] = { ":m .+1<CR>", "move line down" },
	},

	i = {
		["jk"] = { "<esc>", "faster exit to normal mode" },
		["kj"] = { "<esc>", "faster exit to normal mode" },
	},

	v = {
		["p"] = { '"_dP', "hold the value while pasting continuously" },
		["<"] = { "<gv", "stay in indent mode (indent left)" },
		[">"] = { ">gv", "stay in indent mode (indent right)" },
		["<S-k>"] = { ":m '<-2<CR>gv=gv", "move line up" },
		["<S-j>"] = { ":m '>+1<CR>gv=gv", "move line down" },
	},
}

M.hop = {
	n = {
		["<leader>s"] = { "<cmd> HopWord<cr>", "jump to word" },
		["<leader>fp"] = { "<cmd> HopPattern<cr>", "jump to pattern" },
	},
}

return M
