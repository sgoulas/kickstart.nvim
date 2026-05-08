-- Treesitter - Neovim 0.12 has native treesitter support
-- Highlighting and indent are enabled by default
-- Keeping plugin only for parser installation via :TSInstall / :TSUpdate
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
}
