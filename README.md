# Neovim + Tmux Development Environment

This is my personal Neovim configuration built on top of Kickstart.nvim, with seamless tmux integration, clipboard synchronization, and optimized for remote development.

## Key Features

- **Seamless Navigation**: Use `<C-hjkl>` to navigate between Neovim splits and tmux panes
- **Universal Clipboard**: Automatic clipboard sync between local macOS and remote SSH/mosh sessions
- **Floating Terminals**: Quick access terminals with `<C-\>` without leaving Neovim
- **Smart Copy/Paste**: Hold `⌥ (Option)` while selecting text to bypass mouse mode

## Quick Start

### Prerequisites

```bash
# macOS
brew install neovim tmux ripgrep fd

# Clone this config
git clone <your-repo> ~/config/nvim

# Install tmux plugin manager (optional but recommended)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Link tmux config
ln -s ~/config/tmux/tmux.conf ~/.tmux.conf
```

### First Launch

1. Start Neovim: `nvim`
   - Plugins will auto-install via lazy.nvim
   
2. Start tmux: `tmux`
   - Press `Ctrl-a` then `I` to install tmux plugins (if using TPM)
   - Press `Ctrl-a` then `r` to reload config

3. Use the dev session script for a full layout:
   ```bash
   ~/config/tmux/dev-session.sh
   ```

## Navigation

### Window/Pane Movement

- `<C-h/j/k/l>` - Move between Neovim splits AND tmux panes seamlessly
- `<C-w>` then `h/j/k/l` - Alternative window navigation in Neovim
- `<leader>tj` - Toggle hjkl movement reminder

### Tmux Prefix Key: `Ctrl-a`

- `Ctrl-a |` - Split pane vertically
- `Ctrl-a -` - Split pane horizontally
- `Ctrl-a c` - New window
- `Ctrl-a n/p` - Next/previous window
- `Ctrl-a [` - Enter copy mode (vim-style navigation)

## Copy & Paste

### In Neovim (Local)

- **Normal Mode**: Regular vim yanks work as expected
- **Mouse Selection**: Hold `⌥ (Option)` while dragging to bypass mouse mode
- **Visual Mode**: Select with `v`, copy with `y`

### In SSH/Mosh Sessions

All yanks automatically sync to your local macOS clipboard via OSC52:

- `yy` - Copy line to local clipboard
- `yiw` - Copy word to local clipboard
- `y$` - Copy to end of line
- Visual mode + `y` - Copy selection

For explicit OSC52 copy:
- `<leader>y{motion}` - Copy motion to clipboard
- `<leader>yy` - Copy current line

### In Tmux Copy Mode

1. Enter copy mode: `Ctrl-a [`
2. Navigate with vim keys (hjkl)
3. `v` to start selection
4. `y` to copy (automatically syncs to system clipboard)
5. `q` to exit

## Terminal Integration

### ToggleTerm (within Neovim)

- `<C-\>` - Toggle floating terminal
- `<leader>tf` - Floating terminal
- `<leader>th` - Horizontal terminal
- `<leader>tv` - Vertical terminal
- `<leader>tg` - Lazygit in floating terminal
- `<leader>tp` - Python REPL
- `<leader>tn` - Node REPL

### Terminal Navigation

- From terminal mode: `<C-hjkl>` still works to navigate to other panes
- Exit terminal mode: `<Esc>` or `<C-\><C-n>`

## File Management

- `-` - Open parent directory in Oil.nvim (file manager)
- `<leader>sf` - Find files (git-aware)
- `<leader>sg` - Live grep in project
- `<leader>sp` - Find ALL files (including ignored)

## Development Workflow

### Session Management

The included `dev-session.sh` script creates a directory-based tmux layout:

```
┌─────────────┬─────────────┐
│             │    zsh      │
│     vim     ├─────────────┤
│     (50%)   │   claude    │
└─────────────┴─────────────┘
```

- **Automatic naming**: Each directory gets its own session (e.g., `~/myproject` → session "myproject")
- **All panes start in the current directory**
- **Layout**: Vim (left 50%), zsh (top right), Claude Code (bottom right)

### Usage

```bash
# In ~/projects/myapp
dev                    # Creates session "myapp"

# In ~/projects/another-app  
dev                    # Creates session "another-app"

# Override with custom name
dev work              # Creates session "work" in current dir
```

### Recommended Aliases

Add to your `~/.zshrc`:

```bash
# Development
alias dev='~/config/tmux/dev-session.sh'

# Session management
alias tls='tmux ls'                          # List all sessions
alias ta='tmux attach -t'                    # Attach to session: ta myproject
alias tks='tmux kill-session -t'            # Kill session: tks myproject
alias tka='tmux kill-server'                 # Kill ALL tmux sessions

# Quick project switching
alias twork='cd ~/work && dev'
alias tproj='cd ~/projects && dev'
```

## GitHub Copilot Keybindings

### Accepting Suggestions
- `Ctrl+Enter` or `Ctrl+J` - Accept current suggestion (insert mode)

### Navigation
- `Alt+]` - Next suggestion (insert mode)
- `Alt+[` - Previous suggestion (insert mode)
- `Ctrl+E` - Dismiss current suggestion (insert mode)

### Panel & Commands
- `<leader>cp` - Open Copilot panel (normal mode)
- `Ctrl+\` then `Ctrl+P` - Open panel from insert mode
- `<leader>cs` - Trigger new suggestion
- `<leader>cd` - Disable Copilot
- `<leader>ce` - Enable Copilot
- `<leader>cr` - Restart Copilot
- `<leader>ch` or `<leader>c?` - View Copilot help

## Troubleshooting

### Copy/Paste Not Working in SSH

1. Ensure iTerm2 has "Applications in terminal may access clipboard" enabled
   - Preferences → General → Selection

2. Check if you're in an SSH session:
   ```vim
   :echo $SSH_TTY
   ```

3. Verify OSC52 is working - you should see a notification when entering Neovim over SSH

### Tmux Navigation Not Working

1. Make sure you're using the linked config:
   ```bash
   ls -la ~/.tmux.conf  # Should point to ~/config/tmux/tmux.conf
   ```

2. Reload tmux config: `Ctrl-a r`

3. Check if vim-tmux-navigator is loaded in Neovim:
   ```vim
   :checkhealth
   ```

### TPM Not Installed Warning

If you see "TPM NOT INSTALLED" in tmux status bar:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then press Ctrl-a + I inside tmux
```

## Customization

### Adding Plugins

Create new files in `~/.config/nvim/lua/custom/plugins/`:
```lua
-- example.lua
return {
  'plugin/name',
  config = function()
    -- configuration
  end,
}
```

### Key Mappings

- Leader key is `<Space>`
- See current mappings: `<leader>sk` (Search Keymaps)
- Which-key will show available mappings when you press `<leader>`

### Tmux Theme

Edit status bar colors in `~/config/tmux/tmux.conf` (search for "Status bar configuration")

## Tips

1. **Copy Mode Alternative**: If mouse selection is tricky, use vim's visual mode or tmux copy mode
2. **Performance**: The config uses `fd` for file finding and `ripgrep` for searching - install both for best performance
3. **Remote Sessions**: Everything is optimized for SSH/mosh - yanks, clipboard, and mouse all work seamlessly

## Credits

- Built on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- Tmux navigation via [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- OSC52 clipboard via [nvim-osc52](https://github.com/ojroques/nvim-osc52)