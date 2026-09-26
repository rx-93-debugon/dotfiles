#!/usr/bin/env bash
set -e
export DEBIAN_FRONTEND=noninteractive

# git-delta のインストール関数
install_delta() {
  if command -v delta &>/dev/null; then
    echo "git-delta is already installed."
    return 0
  fi

  echo "Installing git-delta from GitHub..."
  # GitHub API から最新のバージョンタグを取得 (例: v0.17.0)
  local version
  version=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -oP '"tag_name": "\K[^"]*')

  # ダウンロードとインストール
  curl -Lo delta.deb "https://github.com/dandavison/delta/releases/download/${version}/git-delta_${version}_amd64.deb"
  dpkg -i delta.deb
  rm delta.deb
}

install_neovim() {
  if command -v nvim &>/dev/null; then
    echo "Neovim is already installed."
    return 0
  fi

  echo "Installing the latest Neovim from GitHub..."

  local version
  version=$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -oP '"tag_name": "\K[^"]*')

  local tgz_name="nvim-linux-x86_64.tar.gz"

  curl -Lo "${tgz_name}" "https://github.com/neovim/neovim/releases/download/${version}/${tgz_name}"
  tar xzf "${tgz_name}"

  # パス配置とシンボリックリンク作成
  mkdir -p /opt
  rm -rf /opt/nvim
  mv nvim-linux-x86_64 /opt/nvim
  ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

  rm -f "${tgz_name}"
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_loader.sh"

load_packages apt pkgs

apt update

if [ ${#pkgs[@]} -eq 0 ]; then
  echo "No packages to install for APT."
else
  echo "Installing packages via APT: ${pkgs[*]}"
  apt install -y "${pkgs[@]}"
fi

install_delta
install_neovim

rm -rf /var/lib/apt/lists/*

echo "All settings applied successfully!"
