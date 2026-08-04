#! /bin/bash
# call with
#  curl -Lks https://github.com/TheJoeSchr/dotfiles/raw/copilot/improve-repo-and-install-sh/install.sh -o install.sh && env bash -x install.sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Detect termux
if [ -n "$TERMUX_VERSION" ] || [ "$(uname -o 2>/dev/null)" = "Android" ]; then
    IS_TERMUX=1
else
    IS_TERMUX=0
fi

if [ "$IS_TERMUX" -eq 0 ]; then
    # Sync time (fails on termux without root)
    sudo ntpdate 0.us.pool.ntp.org >/dev/null 2>&1 || true
fi

echo "Setting up dotfiles using GNU stow..."

DOTFILES_DIR="$HOME/projects/dotfiles"
REPO_URL="https://github.com/TheJoeSchr/dotfiles.git"
BRANCH="copilot/improve-repo-and-install-sh"

if ! command -v stow >/dev/null 2>&1; then
    echo "GNU stow is not installed. Installing..."
    if [ "$IS_TERMUX" -eq 1 ]; then
        pkg install -y stow git
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Sy --noconfirm stow git
    elif command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update && sudo apt-get install -y stow git
    else
        echo "Please install stow and git manually."
        exit 1
    fi
fi

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repository..."
    mkdir -p "$HOME/projects"
    git clone -b "$BRANCH" "$REPO_URL" "$DOTFILES_DIR"
else
    echo "Dotfiles repository already exists at $DOTFILES_DIR. Pulling latest..."
    git -C "$DOTFILES_DIR" fetch origin "$BRANCH"
    git -C "$DOTFILES_DIR" checkout "$BRANCH"
    git -C "$DOTFILES_DIR" pull origin "$BRANCH"
fi

cd "$DOTFILES_DIR"

# Initialize submodules
git submodule update --init --recursive

# Packages to stow
PACKAGES="bash git tmux vim x11 config scripts_pkg ssh python node aider misc projects_pkg downloads_pkg"

echo "Stowing packages..."
# Create common directories so stow doesn't symlink the directories themselves
mkdir -p "$HOME/.config" "$HOME/.local" "$HOME/scripts" "$HOME/projects" "$HOME/Downloads" "$HOME/.ssh"

for pkg in $PACKAGES; do
    echo "Stowing $pkg..."
    # Ensure target directories exist to avoid symlinking directories themselves
    stow -R -t "$HOME" "$pkg" || echo "Failed to stow $pkg"
done

touch ~/.vimrc.local
touch ~/.bashrc.local
mkdir -p ~/Downloads

# Fix any legacy bare repo config
rm -rf "$HOME/.cfg"

read -p "run ~/projects/dotfiles/archRiceSystem.fish ?" -n 1 -r -t 15 REPLY || REPLY="n"
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # need to install fish first
  if [ "$IS_TERMUX" -eq 1 ]; then
      pkg install -y fish
  elif command -v pacman >/dev/null 2>&1; then
      sudo pacman -Sy --noconfirm fish
  fi
  chmod +x "$DOTFILES_DIR/archRiceSystem.fish"
  /usr/bin/env fish "$DOTFILES_DIR/archRiceSystem.fish"
fi

read -p "source .bashrc?" -n 1 -r -t 15 REPLY || REPLY="n"
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  . ~/.bashrc
fi

echo "Dotfiles installation complete!"
