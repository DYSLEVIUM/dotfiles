local Utils = require("core.utils")
local icons = require("core.icons").icons

-- return {
--     "Bekaboo/dropbar.nvim",
--     event = { "LspAttach" },
--     opts = {
--         icons = {
--             kinds = {
--               symbols = icons,
--             },
--             ui = {
--               bar = {
--                 separator = "  ",
--               },
--             },
--         },
--          sources = {
--            path = {
--              relative_to = function(_)
--                local current_directory = vim.fn.expand('%:p:h')
--                local parent_directory = vim.fn.fnamemodify(current_directory, ':h')
--                return parent_directory
--              end
--            }
--          },
--          menu = {
--            win_confings = {
--              border = Utils.border_status,
--            },
--          },
--     },
-- }

return {}
