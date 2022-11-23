#!/bin/zsh

DIR_PATH=`dirname "$0"`

/opt/homebrew/bin/fswatch -o $HOME/.zshrc $HOME/.zsh/ $HOME/.config/starship.toml | xargs -n1 zsh $DIR_PATH/commit_changes.sh