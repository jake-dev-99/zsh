# -----------------------------------------------------------------------------
# .zshrc
# -----------------------------------------------------------------------------
# Interactive shell configuration for Zsh.
# Loads common configuration and OS-specific startup hooks.
# -----------------------------------------------------------------------------

###############################
## Preliminary Configuration ##
###############################

# Set path and fpath to be unique and global.
typeset -gU path fpath

# If you come from bash you might have to change your $PATH.
path=(
    "$HOME/bin"
    "/usr/local/bin"
    $path
)

# Source the platform-specific implementations
source "${${(%):-%N}:A:h}/platform.zsh"

# Configure the platform-specific prelinary configuration
platform_profile

#######################
## ZSH Configuration ##
#######################

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Automatically update Oh My Zsh without prompting.
zstyle ':omz:update' mode auto

# Change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
#DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#setopt correct_all # Correct all commands and parameters
setopt correct # Only correct commands

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    alias-finder
    aliases
    chucknorris
    colorize
    compleat
    git-auto-fetch
    gitfast
    jsontools
    node
    npm
    react-native
    rsync
    safe-paste
    sfdx
    ssh
    uv
    virtualenv
    vscode
)

# Auto-Complete (Non-OMZ)
[[ -d "$HOME/.zsh/completion" ]] && fpath=("$HOME/.zsh/completion" $fpath)

# Apply OS-specific configuration required before Oh My Zsh loads.
platform_oh_my_zsh


##############################
## oh-my-zsh Configuration  ##
##############################
# NOTE: This MUST occur AFTER
# zsh configuration and BEFORE
# user configuration
##############################

export ZSH="$HOME/.oh-my-zsh"
source "$ZSH/oh-my-zsh.sh"


########################
## User Configuration ##
########################

# Ensure language is set
export LANG="${LANG:-en_US.UTF-8}"

# Preferred editor
export EDITOR='vim'

# Override LS Colors
export LS_COLORS=$LS_COLORS":di=1;36"
export LS_COLORS=$LS_COLORS":fi=1;37"
export LS_COLORS=$LS_COLORS":ln=1;35"
export LS_COLORS=$LS_COLORS":pi=1;37"
export LS_COLORS=$LS_COLORS":so=1;37"
export LS_COLORS=$LS_COLORS":bd=1;37"
export LS_COLORS=$LS_COLORS":cd=1;37"
export LS_COLORS=$LS_COLORS":or=4;31"
export LS_COLORS=$LS_COLORS":mi=4;31"
export LS_COLORS=$LS_COLORS":ex=1;32"
export LS_COLORS=$LS_COLORS":*.img=1;37"

# Alias Definitions. For a full list of active aliases, run `alias`.
alias lsl='ls -lAh'
alias flush='printf "\ec\e[3J"'
alias nano='sudo vi'
alias l='ls -lAh'


#############################
## Universal Tooling Setup ##
#############################

# SSH Setup
ps aux | grep -q 'ssh-agent' || eval "$(ssh-agent -s)" >/dev/null

# Node Setup
export NODE_BINARY="$(command -v node)"

# Apply remaining OS-specific user and tooling configuration.
platform_final
