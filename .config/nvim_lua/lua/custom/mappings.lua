}

M.resize = {
  n = {
    ["<C-Up>"] = { "<cmd> resize +2<cr>", "increase horizontal window size" },
    ["<C-Down>"] = { "<cmd> resize -2<cr>", "decrease horizontal window size" },
    ["<C-Left>"] = { "<cmd> vertical resize -2<cr>", "decrease vertical window size"},
    ["<C-Right>"] = { "<cmd> vertical resize +2<cr>", "increase vertical window size"},
  }
}

M.qualityOfLife = {
  n = {
    ["<C-a>"] = { "gg<S-v>G", "select all" }
  },

  i = {
    ["jk"] = { "<esc>", "faster exit to normal mode"},
  },

  v = {
    ["p"] = { '"_dP', "hold the value while pasting continuously"},
    ["<"] = { "<gv", "stay in indent mode (indent left)" },
    [">"] = { ">gv", "stay in indent mode (indent right)" },
  }
}

M.hop = {
  n = {
    ["<leader>f"] = { "<cmd> HopWord<cr>", "" },
    ["<leader>fp"] = { "<cmd> HopPattern<cr>", "" },
  }
}

return M
