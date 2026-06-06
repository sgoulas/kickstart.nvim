-- nvim-scrollbar - Scrollbar with per-severity diagnostic signs
return {
  'petertriho/nvim-scrollbar',
  event = 'VeryLazy',
  opts = {
    handle = {
      hide_if_all_visible = true,
    },
    marks = {
      Error = {
        text = { '✘', '✘' },
        priority = 2,
        highlight = 'DiagnosticVirtualTextError',
      },
      Warn = {
        text = { '▲', '▲' },
        priority = 3,
        highlight = 'DiagnosticVirtualTextWarn',
      },
      Info = {
        text = { '●', '●' },
        priority = 4,
        highlight = 'DiagnosticVirtualTextInfo',
      },
      Hint = {
        text = { '⚑', '⚑' },
        priority = 5,
        highlight = 'DiagnosticVirtualTextHint',
      },
    },
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = true,
      handle = true,
      search = false,
    },
  },
}
