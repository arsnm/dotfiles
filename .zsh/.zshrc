# shellcheck source-path= $HOME/.zsh/ # specify the folder to search in

for config ($HOME/.zsh/*.zsh) source $config

alias ls="lsd -lah"

eval "$(starship init zsh)"