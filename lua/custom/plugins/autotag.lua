-- nvim-ts-autotag - Auto close and rename HTML/JSX tags
return {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {
        opts = {
            enable_close = true,          -- Auto close tags
            enable_rename = true,         -- Auto rename matching tag
            enable_close_on_slash = true, -- Auto close on trailing </
        },
    },
}
