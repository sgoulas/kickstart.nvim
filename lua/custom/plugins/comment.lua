-- JSX/TSX-aware commenting via native Neovim gc/gcc (0.10+)
return {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = 'VeryLazy',
    config = function()
        vim.g.skip_ts_context_commentstring_module = true

        require('ts_context_commentstring').setup({
            enable_autocmd = false,
        })

        -- Hook into native commenting so it uses treesitter-aware commentstring
        local get_option = vim.filetype.get_option
        vim.filetype.get_option = function(filetype, option)
            return option == 'commentstring'
                and require('ts_context_commentstring.internal').calculate_commentstring()
                or get_option(filetype, option)
        end
    end,
}
