#user configuration

autoload zmv

#pyenv configuration
PATH=$(pyenv root)/shims:$PATH

# opam configuration
[[ ! -r /Users/arsnm/.opam/opam-init/init.zsh ]] || source /Users/arsnm/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Virtual environment.
# Show current virtual environment (Python).
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
