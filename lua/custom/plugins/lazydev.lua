-- Lazydev - Configures Lua LSP for Neovim config, runtime and plugins
return {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
        library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
    },
}
