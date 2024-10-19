#
# zsh configuration
#

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# specific configuration for linux systems
if [[ "$(uname)" == "Linux" ]]; then
    PATH=$PATH:/snap/bin #add snap packages to PATH
    ssh-add -q ~/.ssh/id_ed25519
    PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH # add texlive to path
fi

autoload zmv

# specific confiuration for macos systems
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH=/opt/homebrew/bin:$PATH
    ssh-add -q --apple-use-keychain ~/.ssh/id_ed25519
    ssh-add -q --apple-use-keychain ~/.ssh/ssh_telecom
    PATH=/usr/local/texlive/2024/bin/universal-darwin:$PATH # add texlive to path
fi

# pyenv configuration
PATH=$HOME/.pyenv/bin:$PATH
PATH=$(pyenv root)/shims:$PATH
eval "$(pyenv init -)"

# opam configuration
[[ ! -r /Users/arsnm/.opam/opam-init/init.zsh ]] || source /Users/arsnm/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# texlive configuration
MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH
INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH

# add all other configuration files
source $XDG_CONFIG_HOME/zsh/omz.zsh
source $XDG_CONFIG_HOME/zsh/env.zsh
source $XDG_CONFIG_HOME/zsh/aliases.zsh
source $XDG_CONFIG_HOME/zsh/functions.zsh
