return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
                view = "mini",
            },
        },
        presets = {
            bottom_search = true,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = true,
        },
        cmdline = {
            enabled = true,
            view = "cmdline_popup",
            format = {
                cmdline = { pattern = "^:", icon = "", lang = "vim" },
            }
        },
        views = {
            cmdline_popup = {
                position = {
                    row = 5,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = 8,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = "single",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
            },
        },
    },
    keys = {
        {
            "<S-Enter>",
            function() require("noice").redirect(vim.fn.getcmdline()) end,
            mode = "c",
            desc =
            "Redirect Cmdline"
        },
        {
            "<leader>snl",
            function() require("noice").cmd("last") end,
            desc =
            "Noice Last Message"
        },
        {
            "<leader>snh",
            function() require("noice").cmd("history") end,
            desc =
            "Noice History"
        },
        {
            "<leader>sna",
            function() require("noice").cmd("all") end,
            desc =
            "Noice All"
        },
        {
            "<leader>snd",
            function() require("noice").cmd("dismiss") end,
            desc =
            "Dismiss All"
        },
        {
            "<c-f>",
            function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
            silent = true,
            expr = true,
            desc =
            "Scroll forward",
            mode = { "i", "n", "s" }
        },
        {
            "<c-b>",
            function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
            silent = true,
            expr = true,
            desc =
            "Scroll backward",
            mode = { "i", "n", "s" }
        },
    },
}
