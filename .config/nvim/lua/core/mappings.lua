-- n, v, i, t = mode names
local M = {}

M.general = {
    i = {
        -- go to  beginning and end
        ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
        ["<C-e>"] = { "<End>", "End of line" },

        -- navigate within insert mode
        ["<C-h>"] = { "<Left>", "Move left" },
        ["<C-l>"] = { "<Right>", "Move right" },
        ["<C-j>"] = { "<Down>", "Move down" },
        ["<C-k>"] = { "<Up>", "Move up" }
    },

    n = {
        ["<Esc>"] = { ":noh <CR>", "Clear highlights" },
        
        -- switch between windows
        -- ["<C-h>"] = { "<C-w>h", "Window left" },
        -- ["<C-l>"] = { "<C-w>l", "Window right" },
        -- ["<C-j>"] = { "<C-w>j", "Window down" },
        -- ["<C-k>"] = { "<C-w>k", "Window up" },

        -- tmux navigator
        ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
        ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },
        ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
        ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },

        -- save
        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

        -- Copy all
        ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

        -- line numbers
        ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
        ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        ["j"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = {
               expr = true
            }
        },
        ["k"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = {
                expr = true
            }
        },
        ["<Up>"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = {
                expr = true
            }
        },
        ["<Down>"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = {
                expr = true
            }
        },

        -- new buffer
        ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
        ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

        ["<leader>fm"] = { function()
            vim.lsp.buf.format {
                async = true
            }
        end, "LSP formatting" }
    },

    t = {
        ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" }
    },

    v = {
        ["<Up>"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = {
                expr = true
            }
        },
        ["<Down>"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = {
                expr = true
            }
        }
    },

    x = {
        ["j"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = {
                expr = true
            }
        },
        ["k"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = {
                expr = true
            }
        },
        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        ["p"] = {
            'p:let @+=@0<CR>:let @"=@0<CR>',
            "Dont copy replaced text",
            opts = {
                silent = true
            }
        }
    }
}

M.resize = {
    n = {
        ["<C-Up>"] = { "<cmd> resize +2<cr>", "Increase horizontal window size" },
        ["<C-Down>"] = { "<cmd> resize -2<cr>", "Decrease horizontal window size" },
        ["<C-Left>"] = { "<cmd> vertical resize -2<cr>", "Decrease vertical window size" },
        ["<C-Right>"] = { "<cmd> vertical resize +2<cr>", "Increase vertical window size" },
    },
}

M.qualityOfLife = {
    n = {
        ["<C-a>"] = { "gg<S-v>G", "Select all" },
        ["<A-k>"] = { ":m .-2<CR>", "Move line up" },
        ["<A-j>"] = { ":m .+1<CR>", "Move line down" },
    },

    i = {
        ["jk"] = { "<esc>", "Faster exit to normal mode" },
        ["kj"] = { "<esc>", "Faster exit to normal mode" },
    },

    v = {
        ["p"] = { '"_dP', "Hold the value while pasting continuously" },
        ["<"] = { "<gv", "Stay in indent mode (indent left)" },
        [">"] = { ">gv", "Stay in indent mode (indent right)" },
        ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move line up" },
        ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move line down" },
    },
}

-- M.lspconfig = {
--     plugin = true,
--
--     -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
--
--     n = {
--         ["gD"] = { function()
--             vim.lsp.buf.declaration()
--         end, "LSP declaration" },
--
--         ["gd"] = { function()
--             vim.lsp.buf.definition()
--         end, "LSP definition" },
--
--         ["K"] = { function()
--             vim.lsp.buf.hover()
--         end, "LSP hover" },
--
--         ["gi"] = { function()
--             vim.lsp.buf.implementation()
--         end, "LSP implementation" },
--
--         ["<leader>ls"] = { function()
--             vim.lsp.buf.signature_help()
--         end, "LSP signature help" },
--
--         ["<leader>D"] = { function()
--             vim.lsp.buf.type_definition()
--         end, "LSP definition type" },
--
--         --! changed
--         -- ["<leader>ra"] = {function()
--         --     require("nvchad_ui.renamer").open()
--         -- end, "LSP rename"},
--
--         ["<leader>ca"] = { function()
--             vim.lsp.buf.code_action()
--         end, "LSP code action" },
--
--         ["gr"] = { function()
--             vim.lsp.buf.references()
--         end, "LSP references" },
--
--         ["<leader>f"] = { function()
--             vim.diagnostic.open_float {
--                 border = "rounded"
--             }
--         end, "Floating diagnostic" },
--
--         ["[d"] = { function()
--             vim.diagnostic.goto_prev {
--                 float = {
--                     border = "rounded"
--                 }
--             }
--         end, "Goto prev" },
--
--         ["]d"] = { function()
--             vim.diagnostic.goto_next {
--                 float = {
--                     border = "rounded"
--                 }
--             }
--         end, "Goto next" },
--
--         ["<leader>q"] = { function()
--             vim.diagnostic.setloclist()
--         end, "Diagnostic setloclist" },
--
--         ["<leader>wa"] = { function()
--             vim.lsp.buf.add_workspace_folder()
--         end, "Add workspace folder" },
--
--         ["<leader>wr"] = { function()
--             vim.lsp.buf.remove_workspace_folder()
--         end, "Remove workspace folder" },
--
--         ["<leader>wl"] = { function()
--             print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--         end, "List workspace folders" }
--     }
-- }
--
-- M.blankline = {
--     plugin = true,
--
--     n = {
--         ["<leader>cc"] = { function()
--             local ok, start = require("indent_blankline.utils").get_current_context(vim.g
--                 .indent_blankline_context_patterns,
--                 vim.g.indent_blankline_use_treesitter_scope)
--
--             if ok then
--                 vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
--                 vim.cmd [[normal! _]]
--             end
--         end, "Jump to current context" }
--     }
-- }

return M
