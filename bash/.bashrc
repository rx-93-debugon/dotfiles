PS1='\[\e[92m\]\u@\h\[\e[0m\]:\[\e[94m\]\w\[\e[0m\]\$ '

export TERM=xterm-256color
export COLORTERM=truecolor

alias ll='ls -alF'
alias la='ls -A'

alias gs='git status'

HISTCONTROL=ignoredups:erasedups
HISTTIMEFORMAT='%F %T '

shopt -s histappend
