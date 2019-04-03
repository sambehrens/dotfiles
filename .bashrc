# set dataminr home
export DATAMINR_HOME=/Users/sbehrens/Library/Dataminr

function resetMFA() {
    if [ -f ~/resetMFA.sh ]; then
        ~/resetMFA.sh ${1} ${2}
    fi
}

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

DEFAULT=$PS1
PS1="\[\033[0;37m\]\u\[\033[00m\]: \[\033[01;32m\]\W\[\033[00m\]\[\033[01;33m\]\$(parse_git_branch)\[\033[00m\] \$ "
