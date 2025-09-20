#
# zsh configuration
#

# ssh-agent config - DISABLED cause using 1password's ssh_agent for now
# ssh_config() {
#     if [[ "$(uname)" == "Linux" ]]; then
#         if [[ ]]
#         if command -v keychain &>/dev/null; then
#             eval $(keychain --eval --quiet --nogui --noask id_ed25519 ssh_telecom)
#         else
#             echo "keychain is not installed, be aware before using ssh auth."
#         fi
#     elif [[ "$(uname)" == "Darwin" ]]; then
#         if ! pgrep -u "$USER" ssh-agent >/dev/null; then
#             ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
#         fi
#         if [[ -z "$SSH_AUTH_SOCK" ]]; then
#             source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
#         fi
#         ssh-add -q --apple-use-keychain ~/.ssh/id_ed25519
#         ssh-add -q --apple-use-keychain ~/.ssh/ssh_telecom
#     fi
# }
# ssh_config
ssh_config_1pswd(){
    if [[ "$SSH_AUTH_SOCK" != "$HOME/.1password/agent.sock" && -e "$HOME/.1password/agent.sock" ]]; then
        export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
    elif [[ ! -e "$HOME/.1password/agent.sock" ]]; then
        echo "1passowrd ssh-agent is not found (at least not in ~/.1password/)"
        echo "Make sure it is enabled/installed, and on macOS, that the symlink is set :"
        echo 'ln -sf "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ~/.1password/agent.sock'
    fi
}
# ssh_config_1pswd

# homebrew config (if on macOS)
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH=/opt/homebrew/bin:$PATH
fi

# texlive config (add it to PATH)
check_texlive() {
    if [[ -d "/usr/local/texlive" ]]; then
        if [[ "$(uname)" == "Linux" ]]; then
            export PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH
        elif [[ "$(uname)" == "Darwin" ]]; then 
            export PATH=/usr/local/texlive/2024/bin/universal-darwin:$PATH
        fi
        export MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH
        export INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH
    fi
}
check_texlive

# pyenv configuration
check_pyenv() {
    if command -v pyenv &>/dev/null; then
        export PATH=$HOME/.pyenv/bin:$PATH
        pyenv_executable=$(pyenv root)/shims
        export PATH=$pyenv_executable:$PATH
        eval "$(pyenv init -)"
    fi
    }
check_pyenv

# custom app configuration
export PATH=$HOME/bin:$PATH

# add all other configuration files
source $XDG_CONFIG_HOME/zsh/env.zsh
source $XDG_CONFIG_HOME/zsh/aliases.zsh
source $XDG_CONFIG_HOME/zsh/functions.zsh
