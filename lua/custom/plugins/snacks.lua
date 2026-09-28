-- Snacks.nvim - image, lazygit, and scroll modules enabled

-- Dashboard header: dashboard/anael_2.png drawn as a real image (kitty graphics
-- protocol). Terminals without image support get the braille preset header.
local image_file = vim.fn.stdpath 'config' .. '/dashboard/anael_2.png'
local image_max = { width = 60, height = 12 }

-- Reserve blank lines in the dashboard and overlay the image on them
local function dashboard_header(dash)
  if not Snacks.image.supports(image_file) then
    return { section = 'header' }
  end
  local size = Snacks.image.util.fit(image_file, image_max)
  local blank = (' '):rep(size.width)
  local lines = {}
  for i = 1, size.height do
    lines[i] = blank
  end
  return {
    text = { table.concat(lines, '\n') },
    align = 'center',
    padding = 1,
    render = function(_, pos)
      if dash.header_image then
        dash.header_image:close()
      end
      local col = pos[2] + 1 + math.floor((dash.opts.width - size.width) / 2)
      dash.header_image = Snacks.image.placement.new(dash.buf, image_file, {
        pos = { pos[1], col },
        range = { pos[1], col, pos[1] + size.height - 1, col + size.width },
        inline = true,
        conceal = true, -- snacks overlays the blank lines only with conceal on
        width = size.width,
        height = size.height,
      })
    end,
  }
end

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
      sections = {
        dashboard_header,
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
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
    {
      '<leader>du',
      function()
        Snacks.scratch { ft = 'markdown' }
      end,
      desc = 'Toggle dumpyard scratch buffer',
    },
  },
}
