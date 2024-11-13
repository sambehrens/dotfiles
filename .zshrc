# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PATH:`pwd`/flutter/bin"
export PATH="/Users/sbehrens/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home
export JAVA_HOME=~/Library/Java/JavaVirtualMachines/corretto-17.0.10/Contents/Home

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# I'm using starship for my prompt which is set at the bottom of this file
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Get really big history
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
    git
    zsh-autosuggestions
    docker
    z
    nvm
    npm
    vi-mode
    fzf
    fzf-tab
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set editor as vim
export EDITOR='vim'

# Escape with jk in terminal
# commented out because i'm trying to get used to ctrl + [
# bindkey jk vi-cmd-mode

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

source ~/.zsh_aliases
source ~/.bash_aliases

[ -f ~/.zsh_computer_specific.zsh ] && source ~/.zsh_computer_specific.zsh

source ~/.fzfgitfunctions.zsh

# Less won't be used if it fits in the page
export LESS="-F -X $LESS"

# zmodload zsh/complist
# zstyle ':completion:*' menu select

# use the vi navigation keys in menu completion
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

bindkey -M menuselect '?' history-incremental-search-forward

# make ctrl [ faster by removing all multikey bindings starting with ctrl [
# bindkey -rpM viins '^['
# bindkey -rpM vicmd '^['

# activate job control
set -m
# insert last command result
zmodload -i zsh/parameter
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey -M main '^W' insert-last-command-output
bindkey -M vicmd '^W' insert-last-command-output

# rebind fzf cd widget
bindkey -M main '^E' fzf-cd-widget
bindkey -M vicmd '^E' fzf-cd-widget

# execute current autosuggestion
bindkey -M main '^ ' autosuggest-execute
bindkey -M vicmd '^ ' autosuggest-execute

# Easier bindings than going to cmd mode then pressing j or k
bindkey -M main '^K' up-history
bindkey -M main '^J' down-history
bindkey -M vicmd '^K' up-history
bindkey -M vicmd '^J' down-history

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# stop globing with ? and *
unsetopt nomatch

# bat theme
export BAT_THEME="Coldark-Cold"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,underline"

# vi-mode plugin
# set cursor to insert mode
VI_MODE_SET_CURSOR=true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export STARSHIP_CONFIG=~/.starship.toml
eval "$(starship init zsh)"

enable-fzf-tab

# Created by `userpath` on 2022-05-14 00:42:28
export PATH="$PATH:/Users/sambehrens/.local/bin"

# pnpm
export PNPM_HOME="/Users/sbehrens/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

jdk() {
  version=$1
  unset JAVA_HOME;
  export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
  java -version
}

# apple key repeat settings
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
# don't show the accent letters when holding a character down
defaults write -g ApplePressAndHoldEnabled -bool false

# bun completions
[ -s "/Users/sambehrens/.bun/_bun" ] && source "/Users/sambehrens/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
