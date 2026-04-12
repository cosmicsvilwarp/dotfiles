# dotfiles

My personal terminal setup for macOS (Apple Silicon). Clone this repo and run `install.sh` on a new machine to replicate the full environment.

---

## What's included

| Tool | Purpose |
|---|---|
| **WezTerm** | Terminal emulator (GPU-accelerated, transparent) |
| **Zsh + Powerlevel10k** | Shell + prompt theme |
| **Zellij** | Terminal multiplexer (session persistence) |
| **Neovim + LazyVim** | Editor |
| **fzf + fzf-git** | Fuzzy finder + git integration |
| **eza** | Better `ls` with icons |
| **bat** | Better `cat` with syntax highlighting |
| **fd** | Better `find` |
| **zoxide** | Better `cd` (jump to frecent dirs) |
| **zsh-autosuggestions** | Fish-style inline suggestions |
| **zsh-syntax-highlighting** | Command syntax highlighting |

---

## Quick Install

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

> Requires macOS with internet access. Homebrew will be installed automatically if not present.

---

## Directory Structure

```
dotfiles/
├── install.sh                  # Bootstrap script — run this on a new machine
├── homebrew/
│   └── Brewfile                # All Homebrew packages (formulae + casks)
├── zsh/
│   ├── .zshrc                  # Main shell config
│   └── .p10k.zsh               # Powerlevel10k prompt config
├── wezterm/
│   └── .wezterm.lua            # WezTerm terminal config
├── zellij/
│   ├── config.kdl              # Zellij multiplexer config
│   └── themes/
│       └── coolnight.kdl       # Custom "coolnight" color theme
└── nvim/
    ├── init.lua                # Neovim entry point
    ├── lazyvim.json            # LazyVim extras
    └── lua/
        ├── config/
        │   ├── options.lua     # Neovim options
        │   ├── keymaps.lua     # Custom keymaps
        │   └── autocmds.lua    # Autocommands
        └── plugins/
            └── example.lua     # Plugin customizations
```

---

## Color Palette — "coolnight"

Used consistently across WezTerm, Zellij, fzf, and bat.

| Role | Hex |
|---|---|
| Background | `#011423` |
| Foreground | `#CBE0F0` |
| Cursor | `#47FF9C` |
| Selection | `#033259` |
| Cyan | `#24EAF7` |
| Purple | `#a277ff` |
| Green | `#44FFB1` |
| Yellow | `#FFE073` |
| Red | `#E52E2E` |

---

## Keybindings Reference

### WezTerm — Leader: `Alt+Enter`

| Action | Keys |
|---|---|
| Split right | `Alt+Enter` → `\|` |
| Split down | `Alt+Enter` → `-` |
| Navigate panes | `Alt+Enter` → `h/j/k/l` |
| Resize pane | `Alt+Enter` → `←/↓/↑/→` |
| New tab | `Alt+Enter` → `c` |
| Close pane | `Alt+Enter` → `x` |
| Prev/next tab | `Alt+Enter` → `b/n` |
| Jump to tab N | `Alt+Enter` → `0–9` |

### Zellij — Modal (Ctrl combos)

| Mode | Trigger |
|---|---|
| Pane | `Ctrl+P` |
| Tab | `Ctrl+T` |
| Resize | `Ctrl+N` |
| Move | `Ctrl+H` |
| Scroll | `Ctrl+S` |
| Session | `Ctrl+O` |
| Locked | `Ctrl+G` |
| Detach | `Ctrl+O` → `d` |

### fzf

| Action | Keys |
|---|---|
| File search | `Ctrl+F` *(remapped from Ctrl+T to avoid Zellij conflict)* |
| History search | `Ctrl+R` |
| cd into dir | `Alt+C` |

### fzf-git — Leader: `Ctrl+E` *(remapped from Ctrl+G)*

| Action | Keys |
|---|---|
| Git files | `Ctrl+E` → `f` |
| Git branches | `Ctrl+E` → `b` |
| Git tags | `Ctrl+E` → `t` |
| Git remotes | `Ctrl+E` → `r` |
| Git commit hashes | `Ctrl+E` → `h` |
| Git stashes | `Ctrl+E` → `s` |
| Git reflogs | `Ctrl+E` → `l` |
| Git worktrees | `Ctrl+E` → `w` |

---

## Fonts

- **JetBrains Mono** — WezTerm (installed via Homebrew cask)
- **MesloLGS Nerd Font** — Powerlevel10k fallback (installed via Homebrew cask)

---

## After Install Checklist

- [ ] `source ~/.zshrc`
- [ ] Open `nvim` — wait for LazyVim to finish installing plugins
- [ ] Run `:LazyHealth` inside nvim
- [ ] Run `p10k configure` to set up prompt style
- [ ] Reload WezTerm config: `Ctrl+Shift+R`
- [ ] Start Zellij: `zellij`
