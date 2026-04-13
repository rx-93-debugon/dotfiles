#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

apt update
apt install -y \
  tmux \
  git \
  curl \
  fzf \
  ripgrep \
  fd-find

apt install -y \
  build-essential \
  gcc \
  g++ \
  make

curl -LO https://github.com/neovim/neovim/releases/download/v0.12.1/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz
mkdir -p /opt && mv nvim-linux-x86_64 /opt/nvim

ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim

rm -rf nvim-linux64.tar.gz
rm -rf /var/lib/apt/lists/*
