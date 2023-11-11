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
if [[ "$OSTYPE" =~ ^darwin ]]; then
    PATH=$(pyenv root)/shims:$PATH
fi

if [[ "$OSTYPE" =~ ^linux ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi

# opam configuration
[[ ! -r /Users/arsnm/.opam/opam-init/init.zsh ]] || source /Users/arsnm/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# virtual environment.
# show current virtual environment (Python).
spaceship_venv_status() {
  [[ $SPACESHIP_VENV_SHOW == false ]] && return

  # Check if the current directory running via Virtualenv
  [ -n "$VIRTUAL_ENV" ] || return
  echo -n " %Bvia%b "
  echo -n "%{$fg_bold[blue]%}"
  echo -n "$(basename $VIRTUAL_ENV)"
  echo -n "%{$reset_color%}"
}

# texlive configuration
PATH=/usr/local/texlive/2023/bin/x86_64-linux:$PATH
