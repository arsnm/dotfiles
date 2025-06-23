#
# ~/.zshrc
#

# If not running intercatively, don't do anything
[[ $- != *i* ]] && return

export XDG_CONFIG_HOME="$HOME/.config"

source $XDG_CONFIG_HOME/zsh/config.zsh

eval "$(starship init zsh)"

export QSYS_ROOTDIR="/home/arsnm/intelFPGA_lite/24.1std/quartus/sopc_builder/bin"
