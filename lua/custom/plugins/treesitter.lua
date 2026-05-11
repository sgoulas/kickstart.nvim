-- Treesitter - Neovim 0.12 has native treesitter support
-- Highlighting and indent are enabled by default
-- Keeping plugin only for parser installation via :TSInstall / :TSUpdate
local function ensure_treesitter_cli()
    -- The main branch requires the tree-sitter CLI to compile parsers.
    -- Install it via npm if it's not already available.
    if vim.fn.executable('tree-sitter') == 0 and vim.fn.executable('npm') == 1 then
        vim.fn.system({ 'npm', 'install', '-g', 'tree-sitter-cli' })
    end
    vim.cmd('TSUpdate')
end

return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ensure_treesitter_cli,
    update = ensure_treesitter_cli,
}
