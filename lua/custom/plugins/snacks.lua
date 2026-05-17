-- Snacks.nvim - image, lazygit, and scroll modules enabled
return {
  'folke/snacks.nvim',
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {},
    dashboard = {
      preset = {
        header = [[
        ⣿⣿⣿⣿⣯⣿⣿⠄⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠈⣿⣿⣿⣿⣿⣿⣆⠄
        ⢻⣿⣿⣿⣾⣿⢿⣢⣞⣿⣿⣿⣿⣷⣶⣿⣯⣟⣿⢿⡇⢃⢻⣿⣿⣿⣿⣿⢿⡄
        ⠄⢿⣿⣯⣏⣿⣿⣿⡟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣧⣾⢿⣮⣿⣿⣿⣿⣾⣷
        ⠄⣈⣽⢾⣿⣿⣿⣟⣄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣝⣯⢿⣿⣿⣿⣿
        ⣿⠟⣫⢸⣿⢿⣿⣾⣿⢿⣿⣿⢻⣿⣿⣿⢿⣿⣿⣿⢸⣿⣼⣿⣿⣿⣿⣿⣿⣿
        ⡟⢸⣟⢸⣿⠸⣷⣝⢻⠘⣿⣿⢸⢿⣿⣿⠄⣿⣿⣿⡆⢿⣿⣼⣿⣿⣿⣿⢹⣿
        ⡇⣿⡿⣿⣿⢟⠛⠛⠿⡢⢻⣿⣾⣞⣿⡏⠖⢸⣿⢣⣷⡸⣇⣿⣿⣿⢼⡿⣿⣿
        ⣡⢿⡷⣿⣿⣾⣿⣷⣶⣮⣄⣿⣏⣸⣻⣃⠭⠄⠛⠙⠛⠳⠋⣿⣿⣇⠙⣿⢸⣿
        ⠫⣿⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⠻⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣹⢷⣿⡼⠋
         ⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣿⣿⣿  
          ⢻⢹⣿⠸⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣼⣿⣿⣿⣿⡟  
          ⠈⢸⣿ ⠙⢿⣿⣿⣹⣿⣿⣿⣿⣟⡃⣽⣿⣿⡟⠁⣿⣿⢻⣿⣿⢿  
           ⠘⣿⡄  ⠙⢿⣿⣿⣾⣿⣷⣿⣿⣿⠟⠁  ⣿⣿⣾⣿⡟⣿  
            ⢻⡇⠸⣆  ⠈⠻⣿⡿⠿⠛⠉    ⢸⣿⣇⣿⣿⢿⣿  
         ]],
      },
    },
    statuscolumn = {},
    image = {},
    input = {},
    lazygit = {},
    explorer = {},
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          layout = {
            preview = 'main',
            layout = {
              width = 0.25,
            },
          },
          win = {
            list = {
              keys = {
                ['<space>'] = 'confirm',
                ['<cr>'] = 'none',
                ['<C-j>'] = 'preview_scroll_down',
                ['<C-k>'] = 'preview_scroll_up',
              },
            },
          },
        },
      },
    },
    terminal = {},
  },
  keys = {
    {
      '\\',
      function()
        local pickers = Snacks.picker.get { source = 'explorer' }
        if #pickers == 0 then
          Snacks.explorer()
        else
          local picker = pickers[1]
          local list_win = picker.layout.wins and picker.layout.wins.list
          if list_win and list_win.win == vim.api.nvim_get_current_win() then
            picker:close()
          else
            picker:focus 'list'
          end
        end
      end,
      desc = 'File explorer',
    },
    {
      '<leader>lg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Open Lazygit',
    },
    {
      '<leader>la',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit log view',
    },
    {
      '<leader>lf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Lazygit log current file',
    },
    {
      '<C-/>',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Toggle terminal',
      mode = { 'n', 't' },
    },
  },
}
