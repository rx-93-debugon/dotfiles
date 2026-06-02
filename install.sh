#!/bin/bash

ln -sf "$HOME/dotfiles/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$HOME/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config"

link_config() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    rm -rf "$dest"
  fi
  ln -sfn "$src" "$dest"
}

link_config "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
link_config "$HOME/dotfiles/wezterm" "$HOME/.config/wezterm"
link_config "$HOME/dotfiles/lazygit" "$HOME/.config/lazygit"
