#!/usr/bin/env bash

dependencies=("git" "make" "ninja") # Define the list of dependencies to check
for dependency in "${dependencies[@]}"; do # Check if each dependency is installed
  if ! command -v "$dependency" &> /dev/null; then
    echo "$dependency is not installed"
    exit 1
  fi
done
echo 'Dependencies A-okay'

if [ -n "$XDG_CONFIG_HOME" ]; then # Define INSTALL_DIR
  INSTALL_DIR="$XDG_CONFIG_HOME/nvim"
else
  INSTALL_DIR="$HOME/.config/nvim"
fi

# Check if the current working directory is the same as INSTALL_DIR
if [ "$(pwd)" != "$INSTALL_DIR" ]; then
  git clone --depth=1 git@github.com:santigo-zero/fractal-nvim.git "${INSTALL_DIR}"
  git clone --depth=1 https://github.com/neovim/neovim "${INSTALL_DIR}/neovim"
  cd "${INSTALL_DIR}" || exit 3
  git pull
else
  # Try to change to the ./neovim directory or clone the neovim repository
  cd "${INSTALL_DIR}/neovim" || git clone --depth=1 https://github.com/neovim/neovim && cd "${INSTALL_DIR}/neovim" || exit 4
  git pull
fi

cd "${INSTALL_DIR}/neovim" || exit 5
git pull
make CMAKE_INSTALL_PREFIX=~/.local/ install
