return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {},
  keys = {
    { '<leader>q', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '[d', function() require('trouble').prev({ jump = true }) end, desc = 'Previous diagnostic' },
    { ']d', function() require('trouble').next({ jump = true }) end, desc = 'Next diagnostic' },
  },
}
