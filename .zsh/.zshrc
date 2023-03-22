for config in (~/.zsh/*.zsh);
    source "$config"
done

eval "$(starship init zsh)"