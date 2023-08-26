return {
    'edluffy/specs.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        return {
            popup = {
                delay_ms = 100, -- delay before popup displays
                inc_ms = 10,    -- time increments used for fade/resize effects
                blend = 30,     -- starting blend, between 0-100 (fully transparent), see :h winblend
                width = 50,
                winhl = "PMenu",
                fader = require('specs').linear_fader,
                resizer = require('specs').shrink_resizer
            },
        }
    end,
    config = function(_, opts)
        require("specs").setup(opts)
    end
}
