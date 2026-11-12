# Machine setup for this Neovim configuration

This repository holds only the Lua configuration. Some tools that the configuration calls live outside the repository. Install them on each machine after you clone the repository and run the install script.

Use this file to bring a machine to a working state. The target platform is macOS with Homebrew.

## Tools that Neovim installs by itself

Do not install these by hand. The first start of `nvim` gets them:

- `lazy.nvim` and all plugins, pinned by `lazy-lock.json`.
- The treesitter parsers listed in `lua/custom/plugins/treesitter.lua`.
- The language servers and formatters listed in `lua/custom/plugins/lspconfig.lua`. Mason installs them into the Neovim data directory.

Each of these steps needs a tool from the next section, so install that section first.

## Tools to install on the machine

| Tool | Install command | Used by |
|---|---|---|
| Neovim 0.12 or later | `brew install neovim` | everything |
| `git` | `brew install git` | `lazy.nvim`, `gitsigns.nvim` |
| `make` and a C compiler | `xcode-select --install` | `telescope-fzf-native.nvim`, `LuaSnip` jsregexp, treesitter parsers |
| `tree-sitter` CLI | `brew install tree-sitter-cli` | parser builds for `nvim-treesitter` on the `main` branch |
| `ripgrep` | `brew install ripgrep` | Telescope live grep, Snacks picker |
| `fd` | `brew install fd` | Telescope and Snacks file search |
| `lazygit` | `brew install lazygit` | `<leader>lg`, `<leader>la`, `<leader>lf` |
| Node.js and `npm` | `brew install fnm`, then `fnm install --lts` | Mason packages (`pyright`, `cssls`, `somesass_ls`, `oxlint`, `oxfmt`, `prettier`) |
| `mmdc` (mermaid-cli) | `npm install -g @mermaid-js/mermaid-cli` | Snacks image: mermaid diagrams in markdown |
| ImageMagick | `brew install imagemagick` | Snacks image: conversion of non-PNG images |
| A Nerd Font | `brew install --cask font-jetbrains-mono-nerd-font` | icons, because `options.lua` sets `vim.g.have_nerd_font = true` |
| Ghostty | `brew install --cask ghostty` | kitty graphics protocol for the dashboard image and the diagrams |

These tools are optional:

- Ghostscript (`brew install ghostscript`) lets Snacks show PDF files.
- A LaTeX distribution lets Snacks render math in markdown. It also needs the `latex` treesitter parser, which the configuration does not install.

## Conditions to know

1. If you use `fnm`, install `mmdc` again after each change of the default Node.js version. A global `npm` package belongs to one Node.js version only.
2. If you run Neovim inside `tmux`, add `set -gq allow-passthrough on` to `~/.tmux.conf`. Without it, `tmux` blocks the image protocol, and no image shows.
3. If you do not use Ghostty, use a terminal with the kitty graphics protocol, for example kitty or WezTerm. In other terminals the dashboard shows the braille header and diagrams do not render.

## Procedure

1. Install the tools in the table above.
2. Start `nvim` and wait until `lazy.nvim` installs the plugins.
3. Quit `nvim` and start it again.
4. Run `:Lazy` and make sure that no plugin shows a build error.
5. Run `:Mason` and make sure that all packages show as installed.
6. Run `:checkhealth snacks` and examine the `Snacks.image` and `Snacks.lazygit` sections.
7. Open a markdown file that contains a `mermaid` code block, and make sure that the diagram shows under the block.
