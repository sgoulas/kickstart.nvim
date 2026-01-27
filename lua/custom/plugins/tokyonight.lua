-- Tokyonight colorscheme
return {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
        require('tokyonight').setup {
            styles = {
                comments = { italic = false },
            },
        }
    end,
}
