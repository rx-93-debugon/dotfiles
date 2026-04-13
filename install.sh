#!/bin/bash

ln -sf ~/dotfiles/bash/.bashrc ~/.bashrc
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

mkdir -p ~/.config
ln -sf ~/dotfiles/nvim ~/.config/nvim
