#!/usr/bin/env bash
set -e
export DEBIAN_FRONTEND=noninteractive

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_loader.sh"

load_packages apt pkgs

apt-get update

if [ ${#pkgs[@]} -eq 0 ]; then
  echo "No packages to install for APT."
else
  echo "Installing packages via APT: ${pkgs[*]}"
  apt-get install -y "${pkgs[@]}"
fi

rm -rf /var/lib/apt/lists/*

echo "All settings applied successfully!"
