#!/bin/bash
# =============================================================================
# Dotfiles Install Script
# Replicates full terminal setup on a new Mac
# =============================================================================

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Starting dotfiles installation..."

# -----------------------------------------------------------------------------
# 1. Homebrew
# -----------------------------------------------------------------------------
echo "Installing Homebrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "  Homebrew already installed, skipping."
fi

echo "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/homebrew/Brewfile"

# -----------------------------------------------------------------------------
# 2. fzf-git.sh
# -----------------------------------------------------------------------------
echo "Installing fzf-git.sh..."
if [ ! -d "$HOME/fzf-git.sh" ]; then
  git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh
else
  echo "  fzf-git.sh already installed, skipping."
fi

# -----------------------------------------------------------------------------
# 3. Zsh config
# -----------------------------------------------------------------------------
echo "Setting up Zsh config..."
cp "$DOTFILES/zsh/.zshrc" ~/.zshrc
cp "$DOTFILES/zsh/.p10k.zsh" ~/.p10k.zsh

# -----------------------------------------------------------------------------
# 4. WezTerm config
# -----------------------------------------------------------------------------
echo "Setting up WezTerm config..."
cp "$DOTFILES/wezterm/.wezterm.lua" ~/.wezterm.lua

# -----------------------------------------------------------------------------
# 5. Zellij config
# -----------------------------------------------------------------------------
echo "Setting up Zellij config..."
mkdir -p ~/.config/zellij/themes
cp "$DOTFILES/zellij/config.kdl" ~/.config/zellij/config.kdl
cp "$DOTFILES/zellij/themes/coolnight.kdl" ~/.config/zellij/themes/coolnight.kdl

# -----------------------------------------------------------------------------
# 6. Neovim / LazyVim
# -----------------------------------------------------------------------------
echo "Setting up Neovim (LazyVim)..."
# Backup existing nvim config if present
[ -d ~/.config/nvim ]       && mv ~/.config/nvim{,.bak}
[ -d ~/.local/share/nvim ]  && mv ~/.local/share/nvim{,.bak}
[ -d ~/.local/state/nvim ]  && mv ~/.local/state/nvim{,.bak}
[ -d ~/.cache/nvim ]        && mv ~/.cache/nvim{,.bak}

# Clone LazyVim starter
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Overlay our custom configs on top of the starter
cp "$DOTFILES/nvim/init.lua"       ~/.config/nvim/init.lua
cp "$DOTFILES/nvim/lazyvim.json"   ~/.config/nvim/lazyvim.json
cp "$DOTFILES/nvim/stylua.toml"    ~/.config/nvim/stylua.toml

cp "$DOTFILES/nvim/lua/config/lazy.lua"     ~/.config/nvim/lua/config/lazy.lua
cp "$DOTFILES/nvim/lua/config/options.lua"   ~/.config/nvim/lua/config/options.lua
cp "$DOTFILES/nvim/lua/config/keymaps.lua"   ~/.config/nvim/lua/config/keymaps.lua
cp "$DOTFILES/nvim/lua/config/autocmds.lua"  ~/.config/nvim/lua/config/autocmds.lua

cp "$DOTFILES/nvim/lua/plugins/alpha.lua"                   ~/.config/nvim/lua/plugins/
cp "$DOTFILES/nvim/lua/plugins/auto-session.lua"            ~/.config/nvim/lua/plugins/
cp "$DOTFILES/nvim/lua/plugins/colorscheme.lua"             ~/.config/nvim/lua/plugins/
cp "$DOTFILES/nvim/lua/plugins/formatting.lua"              ~/.config/nvim/lua/plugins/
cp "$DOTFILES/nvim/lua/plugins/linting.lua"                 ~/.config/nvim/lua/plugins/
cp "$DOTFILES/nvim/lua/plugins/lualine.lua"                 ~/.config/nvim/lua/plugins/
cp "$DOTFILES/nvim/lua/plugins/treesitter-textobjects.lua"  ~/.config/nvim/lua/plugins/
cp "$DOTFILES/nvim/lua/plugins/vim-maximizer.lua"           ~/.config/nvim/lua/plugins/

# Custom treesitter queries for Java/Python
mkdir -p ~/.config/nvim/after/queries/java
mkdir -p ~/.config/nvim/after/queries/python
cp "$DOTFILES/nvim/after/queries/java/textobjects.scm"   ~/.config/nvim/after/queries/java/
cp "$DOTFILES/nvim/after/queries/python/textobjects.scm"  ~/.config/nvim/after/queries/python/

# -----------------------------------------------------------------------------
# 7. Java (jEnv)
# -----------------------------------------------------------------------------
echo "Setting up jEnv..."
if command -v jenv &>/dev/null; then
  eval "$(jenv init -)"
  jenv enable-plugin export
  # Register all installed Java versions
  for jdk in /Library/Java/JavaVirtualMachines/*/Contents/Home; do
    jenv add "$jdk" 2>/dev/null || true
  done
  echo "  Registered Java versions with jEnv."
else
  echo "  jEnv not found — install via: brew install jenv"
fi

# -----------------------------------------------------------------------------
# 8. Python tools
# -----------------------------------------------------------------------------
echo "Installing Python tools (black, isort, pylint)..."
python3 -m pip install --user black isort pylint 2>/dev/null || true

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "Dotfiles installed successfully!"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open WezTerm — config is live"
echo "  3. Run: nvim  (LazyVim will auto-install plugins on first launch)"
echo "  4. Run: p10k configure  to set up your prompt style"
