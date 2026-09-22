#!/bin/bash
set -e

# Homebrew のインストール確認
if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo "Installing packages via Homebrew..."
brew install \
  bash \
  bash-completion@2 \
  tmux \
  git \
  curl \
  fzf \
  ripgrep \
  fd \
  git-delta \
  neovim

# macOS 用の ~/.bash_profile セットアップ（~/.bashrc を読み込む設定）
# 端末固有の設定は ~/.bash_profile に追記可能
if [ ! -f "$HOME/.bash_profile" ]; then
  echo "Creating ~/.bash_profile..."
  echo '[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"' >"$HOME/.bash_profile"
elif ! grep -q '\.bashrc' "$HOME/.bash_profile"; then
  echo "Adding ~/.bashrc loader to ~/.bash_profile..."
  printf '\n[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"\n' >>"$HOME/.bash_profile"
fi

echo "All macOS packages and configurations applied successfully!"
