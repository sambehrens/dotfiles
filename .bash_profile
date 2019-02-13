source ~/.bashrc

#[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
