#
# zsh configuration
#

# ssh-agent config - DISABLED because using bitwarden's ssh_agent for now (see docs/setup_<target>.md for more information)
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

bw_ssh_agent_config() {
    local bw_sock="$HOME/.bitwarden-ssh-agent.sock"
    local use_bw=false

    if uname -r | grep -qi "microsoft"; then
        # Only attempt bridging if our custom relay tool is available
        if command -v npiperelay.exe >/dev/null 2>&1; then
            if ! ss -a 2>/dev/null | grep -q "$bw_sock"; then
                rm -f "$bw_sock"
                (setsid socat UNIX-LISTEN:"$bw_sock",fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
                sleep 0.5 
            fi
            
            if [ -S "$bw_sock" ]; then
                use_bw=true
            fi
        fi
    elif [ -S "$bw_sock" ]; then
        use_bw=true
    fi

    if [ "$use_bw" = true ]; then
        export SSH_AUTH_SOCK="$bw_sock"
    else
        # Fallback to standard ssh-agent if no valid socket exists
        if [ -z "$SSH_AUTH_SOCK" ] || [ ! -S "$SSH_AUTH_SOCK" ]; then
            eval "$(ssh-agent -s)" >/dev/null
        fi
    fi
}
bw_ssh_agent_config

# homebrew config (if on macOS)
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH=/opt/homebrew/bin:$PATH
fi

# texlive config (add it to PATH)
check_texlive() {
    if [[ -d "/usr/local/texlive" ]]; then
        if [[ "$(uname)" == "Linux" ]]; then
            export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH
        elif [[ "$(uname)" == "Darwin" ]]; then 
            export PATH=/usr/local/texlive/2024/bin/universal-darwin:$PATH
        fi
        export MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH
        export INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH
    fi
}
check_texlive

autoload zmv

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

# opam configuration
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# custom app configuration
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH

# add all other configuration files
source $XDG_CONFIG_HOME/zsh/omz.zsh
source $XDG_CONFIG_HOME/zsh/env.zsh
source $XDG_CONFIG_HOME/zsh/aliases.zsh
source $XDG_CONFIG_HOME/zsh/functions.zsh

if command -v fasfetch &>/dev/null; then
    fastfetch
fi
