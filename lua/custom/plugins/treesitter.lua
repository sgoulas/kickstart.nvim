-- Treesitter - Neovim 0.12 migration
-- Requires the tree-sitter CLI (brew install tree-sitter-cli)
return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    main = 'nvim-treesitter',
    init = function()
        -- Enable treesitter highlighting and indentation for every filetype
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        -- Auto-install parsers if missing
        local ensure_installed = {
            'lua', 'python', 'typescript', 'tsx', 'javascript',
            'html', 'css', 'scss', 'json', 'yaml', 'toml',
            'bash', 'markdown', 'markdown_inline', 'vim', 'vimdoc',
            'regex', 'diff', 'gitcommit',
        }
        local installed = require('nvim-treesitter.config').get_installed()
        local to_install = vim.iter(ensure_installed)
            :filter(function(parser)
                return not vim.tbl_contains(installed, parser)
            end)
            :totable()
        if #to_install > 0 then
            require('nvim-treesitter').install(to_install)
        end
    end,
}
