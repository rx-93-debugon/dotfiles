#!/usr/bin/env bash

# Bash 4.0 未満の場合はエラーにして終了
if [ "${BASH_VERSINFO[0]:-0}" -lt 4 ]; then
  echo "Error: Bash version 4.0 or higher is required (current: ${BASH_VERSION:-unknown})." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_LIST="$SCRIPT_DIR/packages.list"

# packages.list から指定ターゲット（brew または apt）のパッケージを配列変数に読み込む
# Usage: load_packages <target> <array_var_name>
load_packages() {
  local target="$1"
  local -n out_array="$2"

  if [ ! -f "$PACKAGE_LIST" ]; then
    echo "Error: Package list not found at $PACKAGE_LIST" >&2
    return 1
  fi

  local col=2
  case "$target" in
    brew|macos) col=2 ;;
    apt|ubuntu) col=3 ;;
    *)
      echo "Error: Unknown target '$target'. Supported targets: brew, apt" >&2
      return 1
      ;;
  esac

  echo "Reading packages for $target from $PACKAGE_LIST..."
  mapfile -t out_array < <(awk -v c="$col" '!/^#/ && NF >= c && $c != "-" {print $c}' "$PACKAGE_LIST")
}
