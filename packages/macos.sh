#!/usr/bin/env bash
set -e

# Homebrew のインストール確認
if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

load_packages brew pkgs

if [ ${#pkgs[@]} -eq 0 ]; then
  echo "No packages to install for Homebrew."
else
  echo "Installing packages via Homebrew: ${pkgs[*]}"
  brew install "${pkgs[@]}"
fi

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
