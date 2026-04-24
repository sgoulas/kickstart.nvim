-- Snacks.nvim - only image and lazygit modules enabled
return {
  'folke/snacks.nvim',
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {},
    image = {},
    input = {},
    lazygit = {},
    terminal = {},
  },
  keys = {
    { '<leader>lg', function() Snacks.lazygit() end, desc = 'Open Lazygit' },
    { '<leader>la', function() Snacks.lazygit.log() end, desc = 'Lazygit log view' },
    { '<leader>lf', function() Snacks.lazygit.log_file() end, desc = 'Lazygit log current file' },
    { '<C-/>', function() Snacks.terminal.toggle() end, desc = 'Toggle terminal', mode = { 'n', 't' } },
  },
}