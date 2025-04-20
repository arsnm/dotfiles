#
# zsh aliases
#

alias v=nvim

#cd
alias ..="cd.."
alias scripts="cd $SCRIPTS"
alias school="cd $SCHOOL"
alias dot="cd $DOTFILES"
alias repos="cd $REPOS"
alias glabtelecom="cd $REPOS/gitlab/telecom-paris"
alias c="clear"

#ls
alias ls="ls --color=auto"
alias ll="ls -la"
alias la="ls -lathr"

# finds files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv="sudoedit"
alias sk="killall ssh-agent && source ~/.zshrc"
alias t="tmux"
alias e="exit"

#git
alias gp="git pull"
alias gs="git status"
alias lg="lazygit"

alias ez="v $XDG_CONFIG_HOME/zsh/"
alias eb="v ~/.bashrc"
alias ev="cd ~/.config/nvim && v ."
alias sz="source ~/.zshrc"
alias sbr="source ~/.bashrc"

#fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias jupyternb="jupyter lab --no-browser"
# alias svenv="source .venv/bin/activate" # deprected (see functions.zsh)
