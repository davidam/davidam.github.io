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

# cyan
#PS1="\[\033[0;36m\][\$(date +%H:%M)][\u@\h:\w]$\[\033[0m\] "

. /etc/bash_completion
