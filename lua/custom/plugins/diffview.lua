-- Git diff and conflict resolution with side-by-side view
return {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = {
        'DiffviewOpen',
        'DiffviewClose',
        'DiffviewToggleFiles',
        'DiffviewFocusFiles',
        'DiffviewFileHistory',
    },
    keys = {
        { '<leader>gd', '<cmd>DiffviewOpen<cr>',          desc = 'Open Diffview' },
        { '<leader>gD', '<cmd>DiffviewClose<cr>',         desc = 'Close Diffview' },
        { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git file history (current file)' },
        { '<leader>gH', '<cmd>DiffviewFileHistory<cr>',   desc = 'Git file history (all)' },
    },
    opts = {
        enhanced_diff_hl = true,
        use_icons = true,
        view = {
            default = {
                layout = 'diff2_horizontal',
            },
            merge_tool = {
                -- Layout for resolving merge conflicts
                -- diff3_mixed: LOCAL | BASE | REMOTE with merged result below
                layout = 'diff3_mixed',
                disable_diagnostics = true,
            },
            file_history = {
                layout = 'diff2_horizontal',
            },
        },
        file_panel = {
            listing_style = 'tree',
            win_config = {
                position = 'left',
                width = 35,
            },
        },
        keymaps = {
            view = {
                { 'n', '<tab>', '<cmd>DiffviewToggleFiles<cr>', { desc = 'Toggle file panel' } },
                { 'n', 'q',     '<cmd>DiffviewClose<cr>',       { desc = 'Close Diffview' } },
            },
            file_panel = {
                { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } },
            },
            file_history_panel = {
                { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } },
            },
        },
    },
}
