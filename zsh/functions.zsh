#
# zsh functions
#

mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}

svenv() {
    if [ -z "$1" ]; then
        # If no argument is provided, source the local ./.venv/bin/activate
        if [ -f ./.venv/bin/activate ]; then
            source ./.venv/bin/activate
            echo "Activated local virtual environment (.venv)."
        else
            echo "Error: Local virtual environment (.venv) not found."
        fi
    else
        # If an argument is provided, source the corresponding environment from $VENVS_PATH
        if [ -f "$VENVS_PATH/$1/bin/activate" ]; then
            source "$VENVS_PATH/$1/bin/activate"
            echo "Activated virtual environment from $VENVS_PATH/$1."
        else
            echo "Error: Virtual environment $1 not found in $VENVS_PATH."
        fi
    fi
}
