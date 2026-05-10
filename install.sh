#!/bin/bash

ln -sf "$HOME/dotfiles/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$HOME/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config"
ln -sfn "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
ln -sfn "$HOME/dotfiles/wezterm" "$HOME/.config/wezterm"
