#!/bin/bash
# =============================================================================
# Dotfiles Install Script
# Sets up a complete terminal environment on a fresh Mac
# =============================================================================

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ask() {
  printf "%s [y/N] " "$1"
  read -r reply
  [[ "$reply" =~ ^[Yy]$ ]]
}

# -----------------------------------------------------------------------------
# 1. Homebrew
# -----------------------------------------------------------------------------
echo "== Homebrew =="
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found."
  if ask "Install Homebrew?"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Homebrew is required. Exiting."
    exit 1
  fi
else
  echo "Homebrew already installed."
fi

echo "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/homebrew/Brewfile"

# -----------------------------------------------------------------------------
# 2. Python check
# -----------------------------------------------------------------------------
echo ""
echo "== Python =="
BREW_PYTHON="/opt/homebrew/opt/python@3.13/libexec/bin/python3"
if [ -x "$BREW_PYTHON" ]; then
  echo "Homebrew Python 3.13 found."
else
  echo "Homebrew Python 3.13 not found."
  if ask "Install Python 3.13 via Homebrew?"; then
    brew install python@3.13
  else
    echo "Warning: Python tools (black, isort, pylint) require Python."
  fi
fi

# Install Python tools
if [ -x "$BREW_PYTHON" ] || command -v python3 &>/dev/null; then
  PYTHON_CMD="${BREW_PYTHON:-python3}"
  echo "Installing black, isort, pylint..."
  "$PYTHON_CMD" -m pip install --user black isort pylint 2>/dev/null || \
    "$PYTHON_CMD" -m pip install black isort pylint 2>/dev/null || \
    echo "Warning: Failed to install Python tools. Install manually: pip install black isort pylint"
fi

# -----------------------------------------------------------------------------
# 3. Java check
# -----------------------------------------------------------------------------
echo ""
echo "== Java =="
if /usr/libexec/java_home &>/dev/null; then
  echo "Java found:"
  /usr/libexec/java_home -V 2>&1 | head -5
else
  echo "No Java installation found."
  if ask "Install OpenJDK 21 via Homebrew?"; then
    brew install openjdk@21
    sudo ln -sfn /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-21.jdk
    echo "OpenJDK 21 installed."
  else
    echo "Warning: Java LSP (jdtls) requires a JDK. Install one manually if needed."
  fi
fi

# Set up jEnv
if command -v jenv &>/dev/null; then
  eval "$(jenv init -)"
  jenv enable-plugin export 2>/dev/null || true
  for jdk in /Library/Java/JavaVirtualMachines/*/Contents/Home; do
    [ -d "$jdk" ] && jenv add "$jdk" 2>/dev/null || true
  done
  echo "Registered Java versions with jEnv."
fi

# -----------------------------------------------------------------------------
# 4. fzf-git.sh
# -----------------------------------------------------------------------------
echo ""
echo "== fzf-git.sh =="
if [ ! -d "$HOME/fzf-git.sh" ]; then
  git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh
else
  echo "Already installed."
fi

# -----------------------------------------------------------------------------
# 5. Zsh config
# -----------------------------------------------------------------------------
echo ""
echo "== Zsh config =="
cp "$DOTFILES/zsh/.zshrc" ~/.zshrc
cp "$DOTFILES/zsh/.p10k.zsh" ~/.p10k.zsh
echo "Copied .zshrc and .p10k.zsh"

# -----------------------------------------------------------------------------
# 6. WezTerm config
# -----------------------------------------------------------------------------
echo ""
echo "== WezTerm =="
cp "$DOTFILES/wezterm/.wezterm.lua" ~/.wezterm.lua
echo "Copied .wezterm.lua"

# -----------------------------------------------------------------------------
# 7. Zellij config
# -----------------------------------------------------------------------------
echo ""
echo "== Zellij =="
mkdir -p ~/.config/zellij/themes
cp "$DOTFILES/zellij/config.kdl" ~/.config/zellij/config.kdl
cp "$DOTFILES/zellij/themes/coolnight.kdl" ~/.config/zellij/themes/coolnight.kdl
echo "Copied config.kdl and coolnight theme"

# -----------------------------------------------------------------------------
# 8. Neovim / LazyVim
# -----------------------------------------------------------------------------
echo ""
echo "== Neovim (LazyVim) =="

# Backup existing nvim config if present
[ -d ~/.config/nvim ]       && mv ~/.config/nvim{,.bak}       && echo "Backed up existing nvim config"
[ -d ~/.local/share/nvim ]  && mv ~/.local/share/nvim{,.bak}  && echo "Backed up nvim data"
[ -d ~/.local/state/nvim ]  && mv ~/.local/state/nvim{,.bak}  && echo "Backed up nvim state"
[ -d ~/.cache/nvim ]        && mv ~/.cache/nvim{,.bak}        && echo "Backed up nvim cache"

# Clone LazyVim starter
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Overlay custom configs
cp "$DOTFILES/nvim/init.lua"    ~/.config/nvim/init.lua
cp "$DOTFILES/nvim/lazyvim.json" ~/.config/nvim/lazyvim.json
cp "$DOTFILES/nvim/stylua.toml" ~/.config/nvim/stylua.toml

# Config files
for f in lazy.lua options.lua keymaps.lua autocmds.lua; do
  cp "$DOTFILES/nvim/lua/config/$f" ~/.config/nvim/lua/config/
done

# Plugin files
for f in "$DOTFILES"/nvim/lua/plugins/*.lua; do
  cp "$f" ~/.config/nvim/lua/plugins/
done

# Custom treesitter queries
mkdir -p ~/.config/nvim/after/queries/java
mkdir -p ~/.config/nvim/after/queries/python
cp "$DOTFILES/nvim/after/queries/java/textobjects.scm"  ~/.config/nvim/after/queries/java/
cp "$DOTFILES/nvim/after/queries/python/textobjects.scm" ~/.config/nvim/after/queries/python/

echo "Neovim configured. Plugins will auto-install on first launch."

# -----------------------------------------------------------------------------
# 9. Verify installation
# -----------------------------------------------------------------------------
echo ""
echo "== Verification =="

PASS=0
FAIL=0

check() {
  if command -v "$1" &>/dev/null; then
    printf "  %-20s OK\n" "$1"
    PASS=$((PASS + 1))
  else
    printf "  %-20s MISSING\n" "$1"
    FAIL=$((FAIL + 1))
  fi
}

check nvim
check bat
check eza
check fd
check fzf
check rg
check lazygit
check zellij
check zoxide
check gh
check git
check jenv
check node
check python3

echo ""
echo "$PASS passed, $FAIL missing"

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "============================================"
if [ "$FAIL" -eq 0 ]; then
  echo "  All tools installed successfully!"
else
  echo "  Setup complete with $FAIL missing tool(s)."
  echo "  Review the MISSING items above."
fi
echo "============================================"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open nvim (plugins auto-install on first launch)"
echo "  3. Run: p10k configure (to set up your prompt)"
echo ""
