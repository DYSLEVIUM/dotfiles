return {
    'glepnir/dashboard-nvim',
    dependencies = { "nvim-tree/nvim-web-devicons", },
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                -- week_header = {
                --     enable = true,
                -- },
                header = {
                    [[                                                    ]],
                    [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
                    [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
                    [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
                    [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
                    [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
                    [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
                    [[                                                    ]],
                },
                shortcut = {
                    {
                        icon = '󰊳 ',
                        desc = 'Update',
                        action = 'Lazy update',
                        key = 'u'
                    },
                    {
                        icon = ' ',
                        desc = 'Find Files',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        icon = ' ',
                        desc = 'Search Text',
                        action = 'Telescope live_grep',
                        key = 'd',
                    },
                    {
                        icon = ' ',
                        desc = 'Recent Projects',
                        action = 'Telescope projects',
                        key = 'p',
                    },
                    {
                        icon = ' ',
                        desc = 'Recent Files',
                        action = 'Telescope oldfiles',
                        key = 'b',
                    },
                },
            },
        }
    end,
}
