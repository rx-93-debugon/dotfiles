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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_LIST="$SCRIPT_DIR/packages.list"

if [ ! -f "$PACKAGE_LIST" ]; then
  echo "Error: Package list not found at $PACKAGE_LIST" >&2
  exit 1
fi

echo "Reading packages for Homebrew from $PACKAGE_LIST..."
pkgs=()
while IFS= read -r pkg; do
  [ -n "$pkg" ] && pkgs+=("$pkg")
done < <(awk '!/^#/ && NF >= 2 && $2 != "-" {print $2}' "$PACKAGE_LIST")

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
