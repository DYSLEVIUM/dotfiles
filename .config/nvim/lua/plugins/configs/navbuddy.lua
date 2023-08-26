return {
    "SmiteshP/nvim-navbuddy",
    event = "LspAttach",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = function()
    local icons = require("core.icons").icons
      require("nvim-navbuddy").setup({
        icons = icons,
      })
    end,
    cmd = "Navbuddy",
} -- Outline symbols
