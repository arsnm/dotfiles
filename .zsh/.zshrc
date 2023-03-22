# shellcheck source-path= $HOME/.zsh/ # specify the folder to search in

for config ($HOME/.zsh/*.zsh) source $config

eval "$(starship init zsh)"