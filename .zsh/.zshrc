for config in ($HOME/.zsh/*.zsh);
    source $config;
done

eval "$(starship init zsh)"