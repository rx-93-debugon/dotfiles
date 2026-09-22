#!/bin/bash

# macOS 標準 Bash の非推奨警告（zsh 推奨警告）を非表示
export BASH_SILENCE_DEPRECATION_WARNING=1

# Homebrew の環境設定 (Apple Silicon)
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# bash-completion (macOS / Homebrew)
if ! shopt -oq posix; then
  if [ -f "/opt/homebrew/etc/profile.d/bash_completion.sh" ]; then
    . "/opt/homebrew/etc/profile.d/bash_completion.sh"
  fi
fi

# fzf キーバインド (macOS / Homebrew)
if [ -f "/opt/homebrew/opt/fzf/shell/key-bindings.bash" ]; then
  source "/opt/homebrew/opt/fzf/shell/key-bindings.bash"
fi
