# /etc/bash.bashrc
[ -f /etc/profile ] && . /etc/profile

# algunos alias

eval `dircolors`
eval $(lesspipe)
alias ls='ls --color=auto '
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias em='emacs -q -no-site-file -nw'
alias elisp='emacs -q -no-site-file -batch'
alias xterm='xterm -font -*-fixed-medium-r-*-*-18-*-*-*-*-*-iso8859-* -geometry 70x24'
export PS1="\u@\h \[\033[32m\]\w:\[\033[33m\] ($(git branch 2>/dev/null | grep '^*' | colrm 1 2))\[\033[00m\] $ "

# cyan
#PS1="\[\033[0;36m\][\$(date +%H:%M)][\u@\h:\w]$\[\033[0m\] "

. /etc/bash_completion
