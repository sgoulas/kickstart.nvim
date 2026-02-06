-- Neo-tree filve explorer
return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
        { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    config = function()
        require('neo-tree').setup {
            default_component_configs = {
                file_size = {
                    enabled = false,
                },
                git_status = {
                    symbols = {
                        added     = "A",
                        modified  = "M",
                        deleted   = "D",
                        renamed   = "R",
                        untracked = "?",
                        ignored   = "!",
                        unstaged  = "U",
                        staged    = "S",
                        conflict  = "C",
                    },
                },
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                },
                window = {
                    mappings = {
                        ['\\'] = 'close_window',
                    },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
            },
            window = {
                width = "50%",
                mappings = {
                    ['<C-f>'] = 'none',
                    ['<C-b>'] = 'none',
                    ['<C-j>'] = { 'scroll_preview', config = { direction = -10 } },
                    ['<C-k>'] = { 'scroll_preview', config = { direction = 10 } },
                    ['s'] = 'none',
                    ['S'] = 'none',
                    ['x'] = 'open_split',
                    ['v'] = 'open_vsplit',
                },
            },
        }
    end,
}
