-- leap.nvim - Fast motion plugin
return {
    url = 'https://codeberg.org/andyg/leap.nvim',
    event = 'VeryLazy',
    dependencies = {
        'tpope/vim-repeat',
    },
    config = function()
        local leap = require('leap')
        leap.add_default_mappings()
    end,
}
