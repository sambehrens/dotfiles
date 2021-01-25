source ~/.bashrc

#[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# send dataminr home
export DATAMINR_HOME=/Users/sbehrens/Library/Dataminr

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

set completion-ignore-case On

function exit_code() {
    RED='\033[01;31m'
    GRAY='\033[0;37m'
    NC='\033[0m' # No Color

    if [ $1 -eq 0 ]
    then
        echo -e "${GRAY}$1${NC}"
    else
        echo -e "${RED}$1${NC}"
    fi
}

export PS1="\[\033[0;37m\]\u\[\033[00m\]: \[\033[01;32m\]\w\[\033[00m\]\[\033[01;33m\]\$(__git_ps1)\[\033[00m\] \$(exit_code \$?) \$ "

export EDITOR="vim"
bind '"jk":"\e"'

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
