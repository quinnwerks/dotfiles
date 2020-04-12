# Zshrc 
# Author: Quinn Smith
# Date: 2020-01-11

#
# Basic ZSH Setup
#

# Set glob to be case insensitive
setopt NO_CASE_GLOB

# Auto CD so forgetting cd is not a big deal
setopt AUTO_CD

# Enable command history for zsh
setopt EXTENDED_HISTORY
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000

# Enable zsh correction
setopt CORRECT
setopt CORRECT_ALL

# Enable better tab completion
#autoload compinit && compinit

# 
# Aliases
#

# Alias for a nice ls
local LS="ls --color"
alias ls="$LS"
alias ll="$LS -al"

# Alias for clear
alias cls="clear"

#
# Configure the prompt
#
setopt PROMPT_SUBST 

# Assume we have colors available. This isn't the 1990's.
autoload colors && colors

# Load VCS Info for querying git
autoload vcs_info && vcs_info
zstyle ':vcs_info:*' enable git

precmd() { vcs_info }

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*'    formats "%b─%m%u%c" 


# The purposes of the following functions are obvious
function get_time() {
    echo "%T"
}
function get_pwd() {
    echo "%~"
}
function get_user() {
    echo "%m"
}
function get_unicode_arrow() {
    echo -e "\u2192"
}

function get_first_line() {
    echo "%{$fg[grey]%}╭─ %{$fg[cyan]%}[$(get_time)] %{$fg[yellow]%}$(get_user): %{$fg[green]%}$(get_pwd) %{$reset_color%}"
}

function get_second_line() {
    echo "%{$fg[grey]%}╰─${vcs_info_msg_0_}%{$fg[grey]%}$(get_unicode_arrow)  %{$reset_color%}"
}


PROMPT='$(get_first_line)
$(get_second_line)'

export TERM=xterm-256color
