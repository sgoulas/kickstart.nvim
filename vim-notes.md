**Note:**

> Many key binds and commands in this document assume you are using Nvim and popular plugins (such as Telescope, fzf, neo-tree, gitsigns, and LSP integrations).  
> Classic Vim may not support all features or key binds out of the box.
> A common workflow for reloading nvim configuration without stepping out of nvim is:
> leader sn to open nvim config files
> apply changes, save and return to previous file
> :source $MYVIMRC (auto complete supported)
> however lazy doesn't support live reloading, because it's lazy.

> With regards to modular plugin folders: When you add `opts = {}`, lazy.nvim automatically calls `require('<pluginName>').setup({})`

# Vim & Nvim Notes

## Todo

- change neo tree open horizontal to another key bind, maybe X, so that I can cut again.
- add `:help motion.tx` somewhere in this file.

---

## Navigating

### Navigating in a Line

- `0`: move to line start
- `$`: move to line end
- `w` or `e`: move to next word (start or end respectively)
- `b`: move to previous word (start)
- `<n>w`: move to the start of the nth word from here
- `<n>e`: move to the end of the nth word from here
- `f` / `t` to move forward to something. `f` includes the char, `t` doesn't. This only work for current line.
- `F` / `T` are the same but backwards.
- `;` and `,` repeat the last character search. E.g `f.;;;;;;` jumps periods forwards then with `,` you can go back. They work similarly to `n` / `N` for searches.

E.g

```js
const result = calculateTotal(price, tax);
```

- placing cursor at start:
  - `f(` jumps to `(`
  - `t(` jumps to `l`
  - `yt(` yanks up until `l`
  - `df(` deletes up to `(` including it.
  - `df.` delete up to and including the period.

### Navigating in a File

- `s{char}{char}` + `flag` jump anywhere with leap.nvim plugin.
- `H`, `M`, `L`: go to high, middle, low position in the screen
- `gm`: go to the middle of the current line (may need virtual edit)
- `ctrl-F` / `ctrl-B`: navigate forwards / backwards
- `gg` / `G`: jump to start / end of file
- `<n>gg`: go to line number `<n>`
- `:<n>`: alternative way to go to a line
- `ctrl-g`: show file line
- `<n>k` / `<n>j`: move up/down by `<n>` lines (useful with `:se relativenumber`)
- `zz`: center current line on screen (useful after jumps) (baked inside n/N)
- `%`: while on a bracket/parenthesis, jump to matching pair
- `}` / `{` move 1 paragraph forward. Works nicely with code that is separated by blank lines. Works with prefixed `count` as well, e.g `5}` jumps 5 paragraphs forward.

### Navigating Between Files & Tabs

- `<n>gt`: go to specific tab number
- `gt`: next tab
- `gT`: previous tab
- `:tab sb <num>` or `:tab sb <buffer-name>`: open buffer as tab
- Rearrange tabs with mouse
- `C-o` / `C-i`: jump back/forward (jump points)
- Reopen closed tab if buffer exists: `:ls`, `:tabnew | b<n>`, or `<leader><leader> C-t`

### Opening URLs

- `gx`: open URL cursor is hovering (comes from `netrw` which is built-in)

### Window Management

- `C-w`: window management shortcuts
- `C-h`, `C-j`, `C-k`, `C-l`: move to window
- `C-w` then `H`, `J`, `K`, `L`: move window (left, bottom, top, right)
- Resize/focus panes with mouse
- `C-wo`: close all other windows

### Tree Inspection & neo-tree

- `:Ex`: open explorer in current window
- `:Vex`: vertical window
- `:Sex`: horizontal window
- `:Tex`: new tab
- `\`: toggle file explorer with current file
- `<space>`: toggle node
- `z`: close all nodes
- `P`: toggle preview mode, `esc` to exit
- `C-k` / `C-j`: up/down
- `x`: horizontal split
- `v`: vertical split
- `t`: tab
- `a`: add (directory if ends with `/`)
- `A`: add directory
- `r`: rename
- `b`: rename base name only
- `d`: delete
- `y` / `p`: yank/paste
- `R`: refresh tree

### Buffers

- `<leader><leader>`: fzf buffer list
- `:ls` / `:buffers`: list opened buffers
- `%`: current buffer, `#`: alternate buffer
- `a`: active, `h`: hidden, `u`: unlisted, `-`: modifiable off, `=`: read-only, `*`: modified, `x`: read errors
- `:bd`: delete current buffer
- `:bd <n>`: delete buffer number `<n>`
- `:rewind`: first buffer
- `:last`: last buffer
- `:buffer <n>` / `:b <n>`: go to buffer number `<n>`
- `:b part_of_name`: search buffer by name

## Editing

### Adding Text

- `a`: add text after cursor (use `ea` to jump to end of next word and enter input mode)
- `A`: go to end of line and enter input mode
- `o`: add new line below and enter input mode
- `O`: add new line above and enter input mode
- `<n>i [text] <Esc>`: write text `<n>` times
- `<leader>o`: add blank line below current line without entering input mode
- `<leader>O`: add blank line above current line without entering input mode

### Copying Text

- `y%`: yank up to matching ()[]{}.
- `yw`: yank current word / useful alternatives: `ye` --> copy until end of current word.
- `yy`: yank current line
- `v` → move → `y`: select and yank specific parts
- `p`: put yanked/copied/deleted text AFTER the cursor
- `P`: put yanked/copied/deleted text AFTER the cursor
- `V`: line-wise visual mode (e.g. `V2j` yanks current and next two lines)
- `yiw`: yank entire word even if cursor is in the middle
- `yiW`: like `yiw` but yanks until it finds whitespaces.
- `yi(`, `yi{`, `yi[` : yank everything _inside_ the first matching pair (parentheses, braces, brackets)
- `ya(`, `ya{`, `ya[` : yank everything _including_ the pair itself
- Works with quotes as well: `yi'`, `ya'`, `yi"`, `ya"`
- By default when yanking then deleting something, what you delete overwrites the buffer that contains what you copied. `"0p` makes it so that you paste the thing you last yanked instead of yanked _or_ deleted. I can opt to change that behavior by mapping `p` to `"0p` and `P` to `"0P`.
- `yf` / `yt` yank until character including / excluding the character.

### Replacing Text

- `r<x>`: replace character under cursor with `<x>`
- `R`: enter replace mode, typing replaces characters
- `cc`: replace whole line
- `ce`: replace from cursor to end of word
- `c$` or `C`: replace from cursor to end of line
- `:s/e/ass`: replace first `e` with `ass` in line
- `:s/e/ass/g`: replace all `e` with `ass` in line
- `:%s/e/ass/g`: replace all `e` with `ass` in file

### Moving text

- `>` / `<` followed by `hjkl` moves text. For example `>l` moves text to the right. You can be anywhere on the line.

### Working with Multiple Lines

- `ctrl-v`: visual block mode
- Move cursor (e.g. `3j`) to select lines
- `Shift-I`: insert at start of selected lines
- Type text, then `Esc` to apply to all selected lines

## Deleting

### Deleting Text and Lines

- `x`: delete character under cursor
- `dw`: delete word
- `d<number>w`: delete number of words
- `dd`: delete current line
- `<number>dd`: delete number of lines
- `d$`: delete from cursor to end of line
- `ggdG`: delete from start to end of file
- `:%d`: delete entire file contents

### Deleting Files

- `:!rm %`: delete the current file (buffer remains open)

### Visual Mode Deleting

- Select with `v` or `ctrl-v`, then `d` to delete selection

### Buffers

- `:bd`: delete/close current buffer
- `:bd <n>`: delete buffer number `<n>` (can specify multiple buffers)

## Searching & Replacing

### Searching Text

- `/`: search forwards
- `?`: search backwards
- `n` / `N`: next/previous match (`n` for `/` is down, for `?` is up)
- `<leader>/`: fzf in current file
- `<leader>s/`: fzf in open files
- `<leader>sw`: search word under cursor across project
- `*`: highlight all occurrences of word under cursor

### Replacing Text

- `r<x>`: replace character under cursor with `<x>`
- `R`: enter replace mode, typing replaces characters
- `cc`: replace whole line
- `ce`: replace from cursor to end of word
- `c$` or `C`: replace from cursor to end of line
- spectre plugin
  - `<leader>sp`: toggle spectre
  - `<leader>rw`: replace word in current file
  - `<leader>rwE`: replace word everywhere

## Modes & Visual Mode

### Modes

- `:set ic`: ignore case in searches
- `:set is`: show partial matches for search phrase
- `:set hls`: highlight all matching phrases
- `:set smartcase`: case sensitive if search contains uppercase
- `:syntax on`: enable syntax highlighting
- `:se relativenumber`: show relative line numbers
- `:se virtualedit=all`: move cursor through "air" (virtual space)

### Visual Mode

- `v`: enter visual mode (character wise selection)
- `V`: enter line Wise visual mode
- `ctrl-v`: visual block mode (select blocks/columns)
- Use movement keys (`w`, `$`, etc.) to expand selection
- After selecting, use `y` to yank, `d` to delete, or `c` to change

## Undo/Redo & Macros

### Undoing & Redoing Commands

- `u`: undo last command
- `U`: undo all changes in current line
- `ctrl-r`: redo last undone command
- `.`: repeat last change in normal mode
- While `:` is open, use up/down arrows to navigate command history
- `u` can undo a `U`; `u` stacks with itself

### Macros

- Record macro: `q` + [register] (e.g. `qw` for register `w`)
- Perform actions, then `q` to stop recording
- Replay macro: `@w`
- Replay macro n times: `<n>@w`
- Macros are stored in registers and live for the session

## Files & Buffers

### Opening Files

- From terminal: `vim <file>` opens file as buffer
- In Vim: `:e <file>` opens file in new buffer
- `:split <file>` / `:vsplit <file>`: open file in split view
- With telescope:
  - `C-x`: open horizontal split
  - `C-v`: open vertical split
  - `C-t`: open in new tab
- With neo-tree:
  - `x`: horizontal split
  - `v`: vertical split
  - `t`: tab
  - `Enter`: open in current window

### Working with Multiple Files / Buffers

- Buffers are used for quick file switching; tabs are for different views
- `[b` / `]b`: jump to previous/next buffer
- `<leader><leader>`: show all buffers (fzf)
- `M-d`: delete highlighted buffer
- Files opened in tabs are also buffers
- `:tabnew <file>`: open file in new tab
- `:ar` / `:args`: list argument files
- `:browse oldfiles`: list recently opened files

### Saving Files

- `:saveas <name>`: save buffer under new name
- `:w`: save current file
- `:w <name>`: save to `<name>` but stay in current buffer
- `:wa`: save all buffers
- `:wqa`: save all and quit

### Updating Vim configurationuration

- configurationuration file: `~/.vimrc`
- Update configurationuration in Vim: `:source ~/.vimrc` or `:so ~/.vimrc`
- Example mapping: `inoremap jk <Esc>` (map `jk` to escape in insert mode)

## configurationuration & UI

### configurationuration

- Vim configurationuration file: `~/.vimrc`
- Update configuration in Vim: `:source ~/.vimrc` or `:so ~/.vimrc`
- Example mapping: `inoremap jk <Esc>` (map `jk` to escape in insert mode)
- For Neovim: configuration file is `~/.configuration/nvim/init.lua`
- Update Neovim configuration: restart nvim or use `:qa` (quit all)

### UI

- `*`: highlight all occurrences of word under cursor
- Relative line numbers: `:se relativenumber`
- Virtual edit: `:se virtualedit=all`
- Syntax highlighting: `:syntax on`

## Advanced / Niche

> **Note:**  
> The following commands and keybinds often require Neovim and plugins (LSP, Telescope, etc.).

### Niche Commands

- `guu`: lowercase line
- `gUU`: uppercase line
- `~`: invert case of character at cursor

### working with spell checkers

- `]s`, `[s` jump to next / previous misspelled word.
- `z=` show spelling suggestions.
- `zg` add word to dictionary.
- `zug` remove word from dictionary.

I can enable spell checking for different languages by adding the following lines in my lua configurationuration:

```lua
vim.opt.spell = true
vim.opt.spelllang = { "en", "el" }
```

keep in mind that there is a small performance hit when using this feature https://neovim.io/doc/user/spell.html#_performance.

### Working with LSPs

- `:LspInfo`: show installed LSPs
- `:Mason`: open plugin manager for language servers
- `:LspRestart`: restart LSPs (sometimes requires restarting nvim)

### Working with Code

- `<leader>q`: opens diagnostics, can navigate through them and press enter to travel to them.
- Comment line: `gcc`
- Comment block: `gc` while having selected multiple lines in visual mode.
- Comment block: `gb` followed by range. E.g `gb5j`.
- Accept autocomplete: `TAB` (was `C-y`)
- Dismiss autocomplete: `C-e`
- Move up/down in autocomplete: `C-u`, `C-d`
- Jump to definition: `gd`
- Jump to declaration: `grd`
- Go to type definition: `grt`
- Open definition in new tab: `<leader>gt`
- Rename symbol: `grn` (opens buffers for project-wide rename, use `:wa` to save all)
- Find all references: `grr`
- Hover: `K` (move inside hover window: `C-w`, close: `q`)
- Find symbol in current document: `gs`
- Find symbol in workspace: `gS`
- Grep text in workspace: `<leader>sg` (escape special characters)
- Show diagnostics: `<leader>sd`
- Add blank line below: `<leader>o`
- Add blank line above: `<leader>O`
- Add line under cursor: `<leader>]`
- Select inside/around pairs: `vi(`, `va(`, `vi{`, `va{`, `vi[`, `va[`, `yi(`, `ya(`, etc.
- Select inside/around quotes: `vi'`, `va'`, `vi"`, `va"`

#### folding

- `zo` open folder under cursor (fold open)
- `zc` close folder under cursor (fold close)
- `za` toggle folder under cursor (fold atoggle)
- `zR` open all folds
- `zM` close all folds
- `zm` / `zr` fold more fold less, this is for "bird's eye overview" of the whole file.

### Gitsigns Keybinds

- `<leader>tb`: toggle blame
- `]c` / `[c`: jump to next/previous git hunk
- `<leader>hp`: preview hunk
- `<leader>gc`: show commits of current file
- `<leader>gs`: git status
- `<leader>hr`: revert current hunk
- `<leader>hd`: preview changes against index

## Neovim

### Custom Changes

- configuration file: `~/.configuration/nvim/init.lua`
- Kickstart installed for quick setup; can fork and personalize for future use
- Uncommented relative numbers configuration for line numbers
- Easiest way to reload configuration: restart nvim (`:qa`)
- Copy current file's relative path: `<leader>cp` (`vim.keymap.set('n', '<leader>cp', ':let @+ = expand("%")<CR>')`)
- Copy absolute path: use `%:p` instead of `%`
- Center line after search jump: `nzz` and `Nzz`
- Show tab numbers: custom `MyTabLine()` function in configuration

### UI & Keybind Customization

- `<leader>ui`: open Telescope with colorscheme preview
- Nerd fonts: set in terminal, not in configuration
- Icons in Telescope: ensure terminal uses Nerd font
- `<leader>ti`: test icons and color schemes (`vim.keymap.set('n', '<leader>ti', ...)`)
- Neo-tree preview up/down remapped to match Telescope (`<C-u>`, `<C-d>`)
- Telescope document/workspace symbols remapped: `gs`, `gS`
- Telescope git status keybind added

### Plugins & LSP

- Lazy: manages nvim-lspconfiguration plugin
- Mason: installs language servers (e.g. typescript, eslint)
- nvim-lspconfiguration: connects servers to Neovim

### Random Tips

- Fuzzy search files: `<leader>sf`
- Fzf current doc: `<leader>/`
- Fuzzy search for `:e`, `:split`, `:vsplit`; tab autocompletes, `C-n`/`C-p` for next/prev
- Telescope: up/down arrows to navigate, `C-k`/`C-f` to move in preview
- `C-/`: show Telescope shortcuts
- Normal mode in Telescope: `?`
- Open file with `Enter`, vertical split with `C-v`, horizontal with `C-x`
- Close pane: `:close` or `C-wq`
- Open terminal in nvim: `:terminal`, `:split | terminal`, `:vsplit | terminal`
- Run shell command: `:!command` (no aliases)
