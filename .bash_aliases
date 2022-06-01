# git
alias ga='git add'
alias gaa='ga .'
alias gap='git add --patch'
alias gai='git add --interactive'

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

alias gcy='yarn commit'
alias gcyr='yarn commit --retry'

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
alias plom='git pull origin master'
alias gpl='git pull'
alias gpls='git stash && gpl && git stash apply'
alias gplr='gpl -r'
alias gplmr='git pull origin master -r'
alias gplro='gpl -r origin'
alias gf='git fetch --prune'
alias gp='git push'
alias gpsh='git push -u origin HEAD'
alias gpf='git push --force-with-lease'
alias gm='git merge'
alias gmm='git merge master'
alias gma='git merge --abort'
alias gd='git diff'
alias gds='gd --staged'
alias gdst='gd --stat'
alias gr='git reset'
alias gra='git reset .'
alias grs='git reset --soft'
alias grh='git reset --hard'
alias grsh='git reset --soft HEAD^'
# reset to upstream branch
alias grhu='git reset --hard @{upstream}'
alias grmc='git rm -r --cached .; git add .'
# git log
alias gl='git log --oneline -n 15'
alias glv='git log'
alias glog='git log --oneline --graph'
alias glop='git log --pretty=format:"(%h) - %an: %s" --graph'
alias glfancy="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias glme='git log --author="Behrens"'
# git stash
alias gsta='git stash'
alias gsap='git stash apply'

# log changes to a line
function gll() {
    git log -L $1,$1:$2
}

alias gdeletelastunpushedcommit='git reset HEAD~1 --hard'
alias gamf='ga && git commit --amend --no-edit && gp --force'
alias gcp='git cherry-pick'
alias grb='git rebase'
alias grbi='git rebase --interactive'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbo='git rebase --onto'
alias grbis='git rebase --interactive --autosquash'
alias grbism='git rebase --interactive --autosquash master'
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
alias gift='cd ~/Documents/giftgo'
alias r='cd ~/Documents/repos'
alias 1='cd ~/Documents/repos/wordz'
alias 2='cd ~/Documents/repos/type-race'

# ANTLR
alias ant='export CLASSPATH=".:/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH"'
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

# Get pid of process using port 5000
alias pid5='lsof -i tcp:5000'
alias kino='kill $(pid5 | grep -Eo "[0-9]{1,5}" | head -1)'

# npm
alias ng="npm list -g --depth=0 2>/dev/null"
alias nl="npm list --depth=0 2>/dev/null"

# lerna
alias lnab='printf "n\n" | yarn lerna publish --no-git-tag-version --no-push --yes=0'

alias cr='cargo run'
alias cc='cargo check'
alias cb='cargo build'

# computer specific aliases
if [ -f ~/.bash_aliases_cspecific ]; then
    . ~/.bash_aliases_cspecific
fi

# advent of code helpers
function day () {
    cd ~/Documents/rust;
    cargo new advent_day_$1_q1
    cargo new advent_day_$1_q2
    cp -v ~/Documents/rust/advent_template.rs ~/Documents/rust/advent_day_$1_q1/src/main.rs
    cd ~/Documents/rust/advent_day_$1_q1
}
