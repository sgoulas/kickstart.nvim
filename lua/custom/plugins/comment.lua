-- Comment.nvim - Toggle comments with JSX/TSX support
return {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
        -- Skip backwards compat routines and speed up loading
        vim.g.skip_ts_context_commentstring_module = true

        require('ts_context_commentstring').setup({
            enable_autocmd = false,
        })

        require('Comment').setup({
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = {
                line = 'gcc',
                block = 'gbc',
            },
            opleader = {
                line = 'gc',
                block = 'gb',
            },
            -- Use ts_context_commentstring to determine comment style
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        })
    end,
}
