# Add git completion to aliases
__git_complete ga _git_add
__git_complete go _git_checkout
__git_complete gm _git_merge
__git_complete pl _git_pull
__git_complete gb _git_branch

# git
alias ga='git add .'
alias gr='git reset .'
alias gs='git status'
alias gc='git commit'
alias go='git checkout '
alias gom='git checkout master'
alias gob='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gdeletemerged='git branch --merged | grep -v \* | xargs git branch -D'
alias plo='git pull origin'
alias gpl='git pull'
alias gp='git push'
alias gph='git push -u origin HEAD'
alias gm='git merge'
alias gmm='git merge master'
alias gd='git diff'

# vi
alias vba='vi ~/.bash_aliases'
alias sba='. ~/.bash_aliases'
alias vbp='vi ~/.bash_profile'
alias sbp='. ~/.bash_profile'
alias vbr='vi ~/.bashrc'
alias vbcs='vi ~/.bash_aliases_cspecific'

# dotfile aliases
alias df='git -C ~ --git-dir ~/.dotfiles/.git/ --work-tree=$HOME'
alias dfd='df diff'
alias dfds='df diff --staged'
alias dfs='df status'
alias dfc='df commit'
alias dfca='df commit -a'
alias dfa='df add'
alias cdf='cd ~/.dotfiles'
alias dfl='df log'
alias dfpl='df pull'
alias dfph='df push'
alias dfsh='df show'
alias dot='dfca -m "Update dotfiles"; df pull; sbp; df push --quiet &'

# computer specific aliases
if [ -f ~/.bash_aliases_cspecific ]; then
    . ~/.bash_aliases_cspecific
fi
