#
# zsh aliases
#

alias v=nvim
alias e="emacsclient -t"
alias egui="emacsclient -r -n"

#cd
alias ..="cd.."
alias scripts="cd $SCRIPTS"
alias school="cd $SCHOOL"
alias dot="cd $DOTFILES"
alias repos="cd $REPOS"
alias mrepos="cd $REPOS/github/arsnm"
alias glabtelecom="cd $REPOS/gitlab/telecom-paris"
alias p="cd $CODE"
alias c="clear"

#ls
alias ls="lsd"
alias ll="lsd -la"
alias la="lsd -lathr"

# finds files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv="sudoedit"
alias t="tmux"

#git
alias gp="git pull"
alias gpp="git push"
alias gs="git status"
alias lg="lazygit"

alias ez="$EDITOR $XDG_CONFIG_HOME/zsh/"
alias eb="$EDITOR ~/.bashrc"
alias ev="cd ~/.config/nvim && $EDITOR ."
alias sz="source ~/.zshrc"
alias sbr="source ~/.bashrc"

#fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

alias jupyternb="jupyter lab --no-browser"

alias vpnt="sudo openvpn $XDG_CONFIG_HOME/openvpn/telecom-paris.ovpn"

if [[ "$(uname)" == "Darwin" ]]; then
    alias xdg-open="open"
fi

if [[ "$(uname)" == "Linux" ]]; then
    alias xdg-open="open"
    # to reboot on Windows (directly through UEFI)
    alias bootwindows="sudo efibootmgr --bootnext 0000 && sudo reboot"
    # to remove unneeded packages (with pacman)
    alias pacclean="sudo pacman -Rnsc $(pacman -Qdtq)"
fi
