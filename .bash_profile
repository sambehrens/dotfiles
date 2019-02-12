source ~/.bashrc

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
