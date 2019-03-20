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
alias gcm='git commit -m'
alias gcmi='gcm "Initial Commit"'
alias go='git checkout '
alias gom='git checkout master'
alias god='git checkout dev'
alias gob='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gbsu='git branch --set-upstream-to'
alias gdeletemerged='git branch --merged | grep -v \* | xargs git branch -D'
alias plo='git pull origin'
alias gpl='git pull'
alias gp='git push'
alias gpsh='git push -u origin HEAD'
alias gm='git merge'
alias gmm='git merge master'
alias gd='git diff'
alias grmc='git rm -r --cached .; git add .'
alias gl='git log'
alias glo='git log --oneline'
alias glog='git log --oneline --graph'
alias grs='git reset --soft HEAD^'

# navigation
alias b='cd -'

# vi
alias vba='vi ~/.bash_aliases'
alias sba='. ~/.bash_aliases'
alias vbp='vi ~/.bash_profile'
alias sbp='. ~/.bash_profile'
alias vbr='vi ~/.bashrc'
alias vbcs='vi ~/.bash_aliases_cspecific'
alias vrc='vi ~/.vimrc'

# scripts
alias mkex='chmod +x'

# background services
alias mgo='mongod --config /usr/local/etc/mongod.conf'

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

# other fun stuff
alias google='open -a "Google Chrome" https://www.google.com/search?q='

# computer specific aliases
if [ -f ~/.bash_aliases_cspecific ]; then
    . ~/.bash_aliases_cspecific
fi
