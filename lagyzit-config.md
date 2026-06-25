# Lazygit side-by-side diff setup (delta)

This is a reproducible runbook based on the GitHub instructions you shared:

- Source: https://github.com/jesseduffield/lazygit/issues/155#issuecomment-2260986940

## Instructions from the GitHub comment (included verbatim in spirit)

1. Install `git-delta`
2. Open Lazygit config file
3. Add this snippet:

```yml
git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never --syntax-theme base16-256 -s
```

4. Close and reopen Lazygit

---

## What we followed on this machine (macOS)

### 1) Install delta

```bash
brew install git-delta
```

### 2) Confirm Lazygit config directory

```bash
lazygit --print-config-dir
```

Expected on macOS (this machine):

```text
~/Library/Application Support/lazygit
```

### 3) Backup config before editing

```bash
cp ~/Library/Application\ Support/lazygit/config.yml \
  ~/Library/Application\ Support/lazygit/config.yml.bak-side-by-side-delta
```

### 4) Configure side-by-side delta pager

We tuned colors for a light setup and kept side-by-side enabled:

```yml
git:
  pagers:
    - colorArg: always
      pager: delta --light --paging=never --side-by-side --line-numbers --syntax-theme GitHub
```

> Note: The original comment uses `git.paging`. On newer Lazygit versions, config may be represented as `git.pagers` (list form). Use whichever your Lazygit version expects.

### 5) Restart Lazygit

Close and reopen Lazygit to apply changes.

---

## Cross-platform paths

Use one of these locations (depends on Lazygit version/install):

### Linux

- `~/.config/lazygit/config.yml`
- `~/.config/jesseduffield/lazygit/config.yml`

### macOS

- `~/Library/Application Support/lazygit/config.yml`
- `~/Library/Application Support/jesseduffield/lazygit/config.yml`

Tip: prefer `lazygit --print-config-dir` instead of guessing.

---

## Linux install options for delta

Pick one package manager that exists on the target machine:

```bash
# Debian/Ubuntu (if available in repo)
sudo apt-get update && sudo apt-get install -y git-delta

# Fedora
sudo dnf install -y git-delta

# Arch
sudo pacman -S --noconfirm git-delta
```

If your distro repo does not provide it, install from upstream release or cargo.

---

## Quick verification checklist

```bash
delta --version
lazygit --version
lazygit --print-config-dir
```

Inside Lazygit, open a file diff and confirm it is side-by-side.

---

## Revert

If anything looks wrong, restore your backup:

```bash
cp <config-path>.bak-side-by-side-delta <config-path>
```
