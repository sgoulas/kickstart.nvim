-- Core Neovim options

-- Set <space> as the leader key (must happen before plugins are loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Force dark theme
vim.o.background = 'dark'

-- Sync clipboard between OS and Neovim
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital letters in search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = { 'en', 'el' }

-- Preview substitutions live, as you type
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 10

-- If performing an operation that would fail due to unsaved changes,
-- raise a dialog asking if you wish to save
vim.o.confirm = true

-- Show numbers next to each tab path
vim.o.tabline = '%!v:lua.MyTabLine()'

function _G.MyTabLine()
    local s = ''
    for i = 1, vim.fn.tabpagenr '$' do
        local buflist = vim.fn.tabpagebuflist(i)
        local winnr = vim.fn.tabpagewinnr(i)
        local bufnr = buflist[winnr]
        local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')
        if bufname == '' then
            bufname = '[No Name]'
        end

        if i == vim.fn.tabpagenr() then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end

        s = s .. ' ' .. i .. ': ' .. bufname .. ' '
    end
    s = s .. '%#TabLineFill#'
    return s
end
