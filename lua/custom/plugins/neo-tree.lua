-- Neo-tree file explorer
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
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
            },
            window = {
                mappings = {
                    ['\\'] = 'close_window',
                },
            },
        },
        window = {
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
    },
}
