source ~/.bashrc

#[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

set completion-ignore-case On

export EDITOR="vim"

# Set bash editing to vim
set -o vi

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/sbehrens/.sdkman"
[[ -s "/Users/sbehrens/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/sbehrens/.sdkman/bin/sdkman-init.sh"
# export PATH="/usr/local/opt/node@12/bin:$PATH"
