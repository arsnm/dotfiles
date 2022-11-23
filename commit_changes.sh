#!/bin/zsh

cd `dirname "$0"`

cp $HOME/.zshrc .
cp -R $HOME/.zsh .
cp $HOME/.config/starship.toml .

git add --all
git commit -m "Sync .dotfiles configs"
git push
