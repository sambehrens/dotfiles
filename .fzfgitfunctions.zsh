# GIT heart FZF
# Copied from https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# -------------
# Note: All of the previews that show a diff should be unified using -u and then
# piped to delta. 
# For some reason it doesn't use the default pager for the fzf preview. Make
# sure delta is installed `brew install delta`.

alias vfzf='vi ~/.fzfgitfunctions.zsh'
alias sfzf='. ~/.fzfgitfunctions.zsh'

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 90% --min-height 20 --preview-window border-left \
      --preview-window wrap \
      --bind "ctrl-a:toggle-all,ctrl-/:toggle-preview,ctrl-n:preview-down,ctrl-p:preview-up,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" "$@"
}

# git status with diff preview
_gg() {
  is_in_git_repo || return
  git -c color.status=always status -uno --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -u -- {-1} | delta | sed 1,4d; \
    bat --style=numbers --color=always {-1})' |
  cut -c4- | sed 's/.* -> //'
}

# git branch with log preview
_gb() {
  is_in_git_repo || return
  git branch -a --color=always --sort=committerdate | grep -v '/HEAD\s' |
  fzf-down --ansi --multi --tac --reverse --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# git tag with show preview
_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

# git log with show preview
_gh() {
  is_in_git_repo || return
  glfancy --color=always $@ |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --expect 'ctrl-f' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | head -1 | xargs git show --color=always -u | delta'
}

# git reflog with show preview
_gj() {
  is_in_git_repo || return
  grl --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always -u | delta' |
  grep -o "[a-f0-9]\{7,\}"
}

# git remote with log preview
_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
  cut -d$'\t' -f1
}

# git stash list with show preview
_gs() {
  is_in_git_repo || return
  git stash list | fzf-down \
      --reverse -d: --preview 'git show --color=always -u {1} | delta' |
  cut -d: -f1
}

# git show changed files with diff preview
_gf() {
  is_in_git_repo || return
  git show --pretty="" --name-only $1  |
  fzf-down -m --ansi --nth 2..,.. \
    --expect 'ctrl-h,ctrl-n' \
    --preview "(git show --color=always --pretty="" -u $1 {-1} | delta | sed 1,4d)"
}

# git checkout
_gu() {
  is_in_git_repo || return
  git branch --color=always --sort=committerdate | grep -v '/HEAD\s' |
  fzf-down --ansi --no-sort --multi --tac --reverse --preview-window right:70% \
    --expect 'ctrl-u,ctrl-h' \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)'
}

# git log for certain file with just that file's changes
_gn() {
  is_in_git_repo || return
  glfancy --color=always --follow -- $@ |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview "grep -o '[a-f0-9]\{7,\}' <<< {} | head -1 | xargs -I {} git show --color=always -u {} $@ | delta"
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

fzf-gf-widget() {
    local lines=$(_gf $1)
    key="$(head -1 <<< "$lines")"
    rest="$(sed 1d <<< "$lines" | sed 's/.* -> //' | tr '\n' ' ' | xargs)"
    zle reset-prompt
    [[ -z "$rest" ]] && return

    case "$key" in
      ctrl-h)
        fzf-gh-widget --follow -- $rest
        ;;
      ctrl-n)
        local result=$(_gn $rest | grep -o "[a-f0-9]\{7,\}")
        zle reset-prompt
        LBUFFER+=$result
        ;;
      *)
        local result=$(echo $rest | join-lines)
        LBUFFER+=$result
      ;;
    esac
}

zle -N fzf-gf-widget
bindkey '^g^f' fzf-gf-widget

fzf-gh-widget() {
    local lines=$(_gh "$@")
    key="$(head -1 <<< "$lines")"
    rest="$(sed 1d <<< "$lines" | grep -o "[a-f0-9]\{7,\}" | head -1)"
    zle reset-prompt
    [[ -z "$rest" ]] && return

    case "$key" in
      ctrl-f)
        fzf-gf-widget $rest
        ;;
      *)
        local result=$(echo $rest | join-lines)
        LBUFFER+=$result
      ;;
    esac
}

zle -N fzf-gh-widget
bindkey '^g^h' fzf-gh-widget

fzf-gu-widget() {
    local lines=$(_gu)
    key="$(head -1 <<< "$lines")"
    rest="$(sed 1d <<< "$lines" | sed 's/^..//' | cut -d' ' -f1 | sed 's#^remotes/##')"
    zle reset-prompt
    [[ -z "$rest" ]] && return

    case "$key" in
      ctrl-u)
          BUFFER="git checkout $rest"
          zle accept-line
        ;;
      ctrl-h)
        fzf-gh-widget $rest
        # local result=$(_gh $rest | grep -o "[a-f0-9]\{7,\}")
        # zle reset-prompt
        # LBUFFER+=$result
        ;;
      *)
          local result=$(echo $rest | join-lines)
          LBUFFER+=$result
        ;;
    esac
}

zle -N fzf-gu-widget
bindkey '^g^u' fzf-gu-widget

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

bind-git-helper g b t r j s
unset -f bind-git-helper
