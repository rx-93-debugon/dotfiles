#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link_config() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    rm -rf "$dest"
  fi
  ln -sfn "$src" "$dest"
}

link_config "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
link_config "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
link_config "$DOTFILES_DIR/.editorconfig" "$HOME/.editorconfig"

mkdir -p "$HOME/.config"

link_config "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link_config "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
link_config "$DOTFILES_DIR/lazygit" "$HOME/.config/lazygit"
