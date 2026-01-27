-- Scroll bar with diagnostic status markers
return {
    'petertriho/nvim-scrollbar',
    event = 'VimEnter',
    opts = {
        marks = {
            Cursor = {
                text = '󰅂',
                priority = 0,
                highlight = 'Normal',
            },
            Error = {
                text = { '●', '●' },
                priority = 2,
                highlight = 'DiagnosticVirtualTextError',
            },
            Warn = {
                text = { '▲', '▲' },
                priority = 3,
                highlight = 'DiagnosticVirtualTextWarn',
            },
            Info = {
                text = { '◯', '◯' },
                priority = 4,
                highlight = 'DiagnosticVirtualTextInfo',
            },
            Hint = {
                text = { '', '' },
                priority = 5,
                highlight = 'DiagnosticVirtualTextHint',
            },
        },
    },
}
