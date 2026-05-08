-- Autocommands

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Folding rules: use treesitter if available, otherwise fallback to syntax
-- foldlevelstart=99 ensures all folds are open by default
vim.opt.foldlevelstart = 99

vim.api.nvim_create_autocmd({ 'FileType' }, {
    callback = function()
        local ok = pcall(vim.treesitter.get_parser)
        if ok then
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        else
            vim.opt.foldmethod = 'syntax'
        end
    end,
})
