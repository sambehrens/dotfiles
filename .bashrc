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
PS1="\[\033[0;37m\]\u\[\033[00m\]: \[\033[01;32m\]\W\[\033[00m\]\[\033[01;33m\]\$(__git_ps1)\[\033[00m\] \$ "

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var home $(echo -n "$HOME")
}
