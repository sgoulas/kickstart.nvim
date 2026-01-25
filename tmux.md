# tmux Command Reference

## Starting & Managing Sessions

```bash
tmux new -s dev              # Create new session named "dev"
tmux kill-server             # Kill all tmux sessions
tmux ls                      # List all sessions
Ctrl-b d                     # Detach from session (keeps running)
tmux attach -t dev           # Reattach to session named "dev"
exit                         # Close current pane/window
```

## Creating & Managing Windows

```bash
Ctrl-b c                     # Create new window
Ctrl-b ,                     # Rename current window
Ctrl-b &                     # Kill current window (with confirmation)
```

## Navigating Between Windows

```bash
Ctrl-b n                     # Next window
Ctrl-b p                     # Previous window
Ctrl-b 0-9                   # Jump to window 0-9
Ctrl-b '                     # Jump to window by name (prompts you)
Ctrl-b w                     # List all windows (use arrows + Enter)
```

## Splitting Panes

```bash
Ctrl-b %                     # Split vertically (left/right)
Ctrl-b "                     # Split horizontally (top/bottom)
```

## Navigating Between Panes

```bash
Ctrl-b ←                     # Move to left pane
Ctrl-b →                     # Move to right pane
Ctrl-b ↑                     # Move to upper pane
Ctrl-b ↓                     # Move to lower pane
Ctrl-b o                     # Cycle through panes
```

## Your Startup Script

```bash
~/start-dev.sh               # Run your custom setup script
chmod +x ~/start-dev.sh      # Make script executable (one-time)
```

---

**Key reminder:** `Ctrl-b` is always pressed and released first, then you press the command key.
