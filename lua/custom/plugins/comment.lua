-- Comment.nvim - Toggle comments
return {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {
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
    },
}
