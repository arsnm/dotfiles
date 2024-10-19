# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set omz theme to be none to use custom prompt (see in ./config.zsh)
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 2

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
    1password
    git
    web-search
    tmux
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
    git-prompt
)

# zsh-vi-mode configuration
ZVM_VI_EDITOR='nvim'

source $ZSH/oh-my-zsh.sh
