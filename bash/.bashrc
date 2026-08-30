PS1='\[\e[92m\]\u@\h\[\e[0m\]:\[\e[94m\]\w\[\e[0m\]\$ '

export TERM=xterm-256color
export COLORTERM=truecolor

alias ll='ls -alF'
alias la='ls -A'

alias gs='git status'

HISTCONTROL=ignoredups:erasedups
HISTTIMEFORMAT='%F %T '

shopt -s histappend

# OSC 7 を送信する関数
function update_terminal_cwd() {
  printf "\e]7;file://%s%s\e\\" "${HOSTNAME}" "${PWD}"
}

# プロンプトを表示する直前にこの関数を呼び出すように設定
PROMPT_COMMAND="update_terminal_cwd;$PROMPT_COMMAND"
