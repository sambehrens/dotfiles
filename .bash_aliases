# git
alias ga='git add'
alias gaa='ga .'
alias gap='git add --patch'
alias gs='git status'
alias gss='git status --short'
alias gc='git commit --verbose'
alias gcm='gc -m'
alias gcf='gc --fixup'
alias gcfh='gcf HEAD'
alias gcfa='gcf $(glo --invert-grep -1 --pretty=format:"%h" --grep=fixup\!)'
alias gcam='gc --amend'
alias gcamn='gc --amend --no-edit'
alias gcmi='gcm "Initial Commit"'
alias go='git checkout '
alias yolo='git commit -m "$(curl -s http://whatthecommit.com/index.txt)"'

# find a branch and check it out
function gof {
    git branch -a | grep -v remotes | grep $1 | head -n 1 | xargs git checkout
}

alias gom='git checkout master'
alias gob='git checkout -b'
alias go-='git checkout -'
alias gb='git branch'
alias gba='git branch -a'
alias gbv='git branch -vv'
alias gbav='git branch -a -vv'
alias gbsu='git branch --set-upstream-to'
alias gbrn='git branch -m'
alias gdeletemerged='git branch --merged | grep -v \* | xargs git branch -D'
alias plo='git pull origin'
alias gpl='git pull'
alias gpls='git stash && gpl && git stash apply'
alias gplr='gpl -r'
alias gplmr='git pull origin master -r'
alias gplro='gpl -r origin'
alias gf='git fetch --prune'
alias gp='git push'
alias gpsh='git push -u origin HEAD'
alias gpf='git push --force'
alias gm='git merge'
alias gmm='git merge master'
alias gma='git merge --abort'
alias gd='git diff'
alias gds='gd --staged'
alias gr='git reset'
alias gra='git reset .'
alias grs='git reset --soft'
alias grsh='git reset --soft HEAD^'
alias grmc='git rm -r --cached .; git add .'
alias gl='git log'
alias glo='git log --oneline'
alias glog='git log --oneline --graph'
alias glop='git log --pretty=format:"(%h) - %an: %s" --graph'

# log changes to a line
function gll() {
    git log -L $1,$1:$2
}

alias glme='git log --author="Behrens"'
alias gdeletelastunpushedcommit='git reset HEAD~1 --hard'
alias gamf='ga && git commit --amend --no-edit && gp --force'
alias gcp='git cherry-pick'
alias grb='git rebase'
alias grbi='git rebase --interactive'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbo='git rebase --onto'
alias grbis='git rebase --interactive --autosquash'
alias grbisa='git rebase --interactive --autosquash $(glo --invert-grep -1 --pretty=format:"%h" --grep=fixup\!)^1'

# reset branch to head
alias grsh='git reset HEAD --hard'
alias grso='git reset origin --hard'

# navigation
alias b='cd -'
alias d='cd ~/Documents'

# vi
alias v='vim'
alias vba='vi ~/.bash_aliases'
alias sba='. ~/.bash_aliases'
alias vbp='vi ~/.bash_profile'
alias sbp='. ~/.bash_profile'
alias vbr='vi ~/.bashrc'
alias vbcs='vi ~/.bash_aliases_cspecific'
alias vrc='vi ~/.vimrc'

# scripts
alias mkex='chmod +x'
alias iterm='cd ~/Library/Application\ Support/iTerm2/Scripts/'
alias cat='bat'

# background services
alias mgo='mongod --config /usr/local/etc/mongod.conf'
alias mpn='top | grep mongod'
alias ip='ifconfig | grep -A 4 en0 | grep "inet " | egrep -oh "([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}" | grep -m 1 ".*"'

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

# python stuff
alias serv='python3 -m http.server 8080'

# other fun stuff
alias google='open -a "Google Chrome" https://www.google.com/search?q='
alias shutdown='sudo shutdown now'
alias restart='sudo shutdown -r now'
alias me='cat ~/me'
alias ws='open -a Webstorm .'
alias pc='open -a Pycharm .'

# java stuff
alias mcp='mvn clean package'
alias j8='export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version'

# directories
alias esof='cd ~/Documents/adv_esof/esof422'
alias gift='cd ~/Documents/giftgo'

# ANTLR
alias ant='export CLASSPATH=".:/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH"'
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

# Get pid of process using port 5000
alias pid5='lsof -i tcp:5000'

# npm
alias ng="npm list -g --depth=0 2>/dev/null"
alias nl="npm list --depth=0 2>/dev/null"

# computer specific aliases
if [ -f ~/.bash_aliases_cspecific ]; then
    . ~/.bash_aliases_cspecific
fi
