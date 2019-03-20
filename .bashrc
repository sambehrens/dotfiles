# set dataminr home
export DATAMINR_HOME=/Users/sbehrens/Library/Dataminr

function resetMFA() {
    if [ -f ~/resetMFA.sh ]; then
        ./resetMFA.sh ${1} ${2}
    fi
}
