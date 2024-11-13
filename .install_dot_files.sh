git clone git@github.com:sambehrens/dotfiles.git ~/.dotfiles

git --git-dir ~/.dotfiles/.git --work-tree=. reset --hard master

git config --global include.path .customgitconfig

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

brew install starship

brew install fzf

brew install git-delta

brew install bat

# Clear pacman animation
brew install orangekame3/tap/paclear

$(brew --prefix)/opt/fzf/install

source ~/.zshrc

brew install ripgrep

# Key Repeat settings for Mac
defaults write -g InitialKeyRepeat -int 12
defaults write -g KeyRepeat -int 2
defaults write -g ApplePressAndHoldEnabled -bool false
