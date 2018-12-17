# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples

#umask 002

export EDITOR='emacs'

PYTHONDONTWRITEBYTECODE=true

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "


# # execute .bashrc if it exists.

# if [ -e ~/.bashrc ]
# then
#   . ~/.bashrc
# fi

# LC_MESSAGES=gl_ES

