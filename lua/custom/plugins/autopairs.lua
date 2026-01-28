return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
        check_ts = true,                  -- Enable treesitter integration
        ts_config = {
            lua = { 'string' },           -- Don't add pairs in lua string treesitter nodes
            javascript = { 'template_string' }, -- Don't add pairs in javascript template_string
        },
        fast_wrap = {
            map = '<M-e>', -- Alt+e to wrap with pair
            chars = { '{', '[', '(', '"', "'" },
            pattern = [=[[%'%"%>%]%)%}%,]]=],
            end_key = '$',
            before_key = 'h',
            after_key = 'l',
            cursor_pos_before = true,
            keys = 'qwertyuiopzxcvbnmasdfghjkl',
            manual_position = true,
            highlight = 'Search',
            highlight_grey = 'Comment',
        },
    },
}
