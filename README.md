# My dotfiles

### Heavily based on [Karl Molina](https://github.com/karlmolina)'s [dotfiles](https://github.com/karlmolina/dotfiles)
_Thanks Karl!_

Uses a git repository inside of $home with the command.
```
alias df='git -C ~ --git-dir ~/.dotfiles/.git --work-tree=$HOME'
```

This changes the working directory to $home. And allows the .git directory to live inside the .dotfiles directory. You could use `git clone --bare` and have the .dotfiles directory to be the .git directory, but then the [master branch isn't set to track the remote](https://git-scm.com/docs/git-clone#git-clone---bare).

See [how to manage your dotfiles with git](https://medium.hackinrio.com/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b).

## Installation

```
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/sambehrens/dotfiles/master/.install_dot_files.sh)"
```

## Updating dotfiles
Use the following alias to commit, pull, source .bash_profile, and push all at once.
```
dot
```

