#!/usr/bin/env bash

INSTALL_DIR="$HOME/.cache/build-nvim"
NEOVIM_DIR="${INSTALL_DIR}/neovim"

# Check dependencies
dependencies=("git" "make" "ninja")
for dependency in "${dependencies[@]}"; do
  if ! command -v "$dependency" &> /dev/null; then
    echo "$dependency is not installed"
    exit 1
  fi
done

# Clone or pull Neovim
if [ -d "$NEOVIM_DIR" ]; then
  # Neovim is already cloned, perform a git pull
  echo "Updating Neovim..."
  cd "$NEOVIM_DIR" || exit 2
  git pull
else
  # Neovim is not cloned, perform a fresh clone
  echo "Cloning Neovim..."
  git clone --depth=1 https://github.com/neovim/neovim "$NEOVIM_DIR"
  cd "$NEOVIM_DIR" || exit 3
fi

# Build and install Neovim
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=~/.local/ install
