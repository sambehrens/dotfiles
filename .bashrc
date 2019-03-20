# set dataminr home
export DATAMINR_HOME=/Users/sbehrens/Library/Dataminr

function resetMFA() {
    token="${1}"
    accountID="${2}"
    set -x

    curl -X POST  \
        --header "Content-Type: application/json"  \
        --header "Accept: application/json"  \
        --header "Authorization: DmAuth ${token}"  \
        -d "{ \"accountIds\": [ ${accountID} ], \"sendResetMFAEmail\": false }"  \
        "https://gateway-stage.dataminr.com/auth/2/mfa/admin/reset" \

    set +x
}
