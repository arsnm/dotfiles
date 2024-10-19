#
# zsh configuration
#


if [[ "$(uname)" == "Linux" ]]; then
    PATH=$PATH:/snap/bin #add snap packages to PATH
fi
autoload zmv

# add Homebrew to PATH for macos
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH=/opt/homebrew/bin:$PATH
fi

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    ssh-add -q --apple-use-keychain ~/.ssh/id_ed25519
    ssh-add -q --apple-use-keychain ~/.ssh/ssh_telecom
else
    ssh-add -q ~/.ssh/id_ed25519
fi

# pyenv configuration
PATH=$HOME/.pyenv/bin:$PATH
PATH=$(pyenv root)/shims:$PATH

eval "$(pyenv init -)"


# opam configuration
[[ ! -r /Users/arsnm/.opam/opam-init/init.zsh ]] || source /Users/arsnm/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# texlive configuration
PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH

# add all other configuration files
source $XDG_CONFIG_HOME/zsh/omz.zsh
source $XDG_CONFIG_HOME/zsh/env.zsh
source $XDG_CONFIG_HOME/zsh/aliases.zsh
source $XDG_CONFIG_HOME/zsh/functions.zsh
