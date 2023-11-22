# user configuration

if [[ "$OSTYPE" =~ ^linux ]]; then
    PATH=$PATH:/snap/bin #add snap packages to PATH
fi
autoload zmv

# keychain and ssh configuration
if [ -x /usr/bin/keychain ]; then
    /usr/bin/keychain --nogui $HOME/.ssh/id_ed25519
    source $HOME/.keychain/$(hostname)-sh
fi

# pyenv configuration
PATH=$HOME/.pyenv/bin:$PATH
PATH=$(pyenv root)/shims:$PATH

eval "$(pyenv init -)"


# opam configuration
[[ ! -r /Users/arsnm/.opam/opam-init/init.zsh ]] || source /Users/arsnm/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# texlive configuration
PATH=/usr/local/texlive/2023/bin/x86_64-linux:$PATH

# cargo configuration
if [[ "$OSTYPE" =~ ^linux ]]; then
    PATH=$PATH:$HOME/.cargo/bin # add cargo to PATH
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure`
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# iterm2 shell integration (zsh)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
