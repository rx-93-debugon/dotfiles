case $- in
  *i*) ;;
  *) return ;;
esac

PS1='\[\e[92m\]\u@\h\[\e[0m\]:\[\e[94m\]\w\[\e[0m\]\$ '

export TERM=xterm-256color
export COLORTERM=truecolor

alias ll='ls -alF'
alias la='ls -A'

alias gs='git status'

HISTCONTROL=ignoredups:erasedups
HISTTIMEFORMAT='%F %T '

shopt -s histappend

# Tab 補完設定 (Readline)
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set mark-symlinked-directories on'

# OS 固有の設定（補完やパス）を読み込む
_bash_dir=""
if [ -f "$HOME/dotfiles/bash/linux.bash" ]; then
  _bash_dir="$HOME/dotfiles/bash"
elif [ -f "$HOME/.dotfiles/bash/linux.bash" ]; then
  _bash_dir="$HOME/.dotfiles/bash"
elif [ -n "${BASH_SOURCE[0]}" ] && [ -f "$(dirname "${BASH_SOURCE[0]}")/linux.bash" ]; then
  _bash_dir="$(dirname "${BASH_SOURCE[0]}")"
fi

if [ -n "$_bash_dir" ]; then
  case "$(uname -s)" in
    Linux*)
      [ -f "$_bash_dir/linux.bash" ] && . "$_bash_dir/linux.bash"
      ;;
    Darwin*)
      [ -f "$_bash_dir/macos.bash" ] && . "$_bash_dir/macos.bash"
      ;;
  esac
fi
unset _bash_dir

# OSC 7 を送信する関数
function update_terminal_cwd() {
  printf "\e]7;file://%s%s\e\\" "${HOSTNAME}" "${PWD}"
}

# プロンプトを表示する直前にこの関数を呼び出すように設定
PROMPT_COMMAND="update_terminal_cwd;$PROMPT_COMMAND"

# Added by Antigravity CLI installer
export PATH="$HOME/.local/bin:$PATH"
