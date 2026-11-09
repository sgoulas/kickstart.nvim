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

-- Prose filetypes: soft-wrap long lines at the window edge, break at word
-- boundaries, and indent wrapped list items under their text.
vim.api.nvim_create_autocmd('FileType', {
    desc = 'Soft wrap for prose filetypes',
    group = vim.api.nvim_create_augroup('prose-soft-wrap', { clear = true }),
    pattern = { 'markdown', 'text', 'gitcommit' },
    callback = function(args)
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.breakindentopt = 'list:-1'
        -- Move by screen line when no count is given, so 5j still jumps real lines
        for _, key in ipairs({ 'j', 'k' }) do
            vim.keymap.set({ 'n', 'x' }, key, function()
                return vim.v.count == 0 and 'g' .. key or key
            end, { buffer = args.buf, expr = true })
        end
    end,
})

-- Markdown: gcc toggles ~~strikethrough~~ on the line instead of commenting it.
-- Leading indent, list markers and task checkboxes stay outside the tildes.
vim.api.nvim_create_autocmd('FileType', {
    desc = 'Markdown gcc toggles strikethrough',
    group = vim.api.nvim_create_augroup('markdown-strikethrough', { clear = true }),
    pattern = 'markdown',
    callback = function(args)
        vim.keymap.set('n', 'gcc', function()
            local start = vim.api.nvim_win_get_cursor(0)[1] - 1
            local lines = vim.api.nvim_buf_get_lines(0, start, start + vim.v.count1, false)
            for i, line in ipairs(lines) do
                local prefix, text = line:match('^(%s*[-*+]%s+%[.%]%s+)(.*)$')
                if not prefix then prefix, text = line:match('^(%s*[-*+]%s+)(.*)$') end
                if not prefix then prefix, text = line:match('^(%s*%d+[.)]%s+)(.*)$') end
                if not prefix then prefix, text = line:match('^(%s*)(.*)$') end
                if text ~= '' then
                    local inner = text:match('^~~(.*)~~$')
                    lines[i] = prefix .. (inner or ('~~' .. text .. '~~'))
                end
            end
            vim.api.nvim_buf_set_lines(0, start, start + #lines, false, lines)
        end, { buffer = args.buf, desc = 'Toggle strikethrough on line' })
    end,
})
