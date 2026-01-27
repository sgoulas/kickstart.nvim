-- Spectre - Find and replace across files
return {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {
            '<leader>sp',
            function()
                require('spectre').toggle()
            end,
            desc = 'Toggle Spectre',
        },
        {
            '<leader>rwE',
            function()
                require('spectre').open_visual { select_word = true }
            end,
            desc = '[r]eplace [w]ord instances [E]verywhere',
        },
        {
            '<leader>rwE',
            function()
                require('spectre').open_visual()
            end,
            mode = 'v',
            desc = '[r]eplace [w]ord instances [E]verywhere',
        },
        {
            '<leader>rw',
            function()
                require('spectre').open_file_search { select_word = true }
            end,
            desc = '[r]eplace [w]ord instances in current file',
        },
    },
}
