# sgoulas Neovim configuration

This is my personal Neovim configuration. It started as a fork of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and is now split into modules under `lua/custom/`.

The target platform is macOS.

## Install

1. Back up any Neovim configuration that is on the machine, and remove `~/.local/share/nvim/`.
2. Clone the repository:

   ```sh
   git clone https://github.com/sgoulas/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
   ```

3. Install the external tools that `AGENTS.md` lists.
4. Start `nvim`. `lazy.nvim` installs the plugins at the first start.
5. Do the checks in the procedure of `AGENTS.md`.

`lazy-lock.json` is in version control, so each machine gets the same plugin versions.

## Layout

| Path | Content |
|---|---|
| `init.lua` | Starts `lazy.nvim` and loads the modules |
| `lua/custom/core/` | Options, keymaps and autocommands |
| `lua/custom/plugins/` | One file for each plugin spec |
| `dashboard/` | Images for the Snacks dashboard |
| `spell/` | Spell files for English and Greek |
| `AGENTS.md` | The tools to install on a machine, and the checks after the install |
| `vim-notes.md` | My notes about Vim commands |
| `tmux.md` | My notes about `tmux` |
