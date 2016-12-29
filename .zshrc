#=====================
# General
#=====================
setopt extendedglob
setopt nomatch
unsetopt beep notify # No bell

# Command not found hook
cmdnf_hook_dir=/usr/share/doc/pkgfile/command-not-found.zsh
[[ -f $cmdnf_hook_dir ]] && source $cmdnf_hook_dir
unset cmdnf_hook_dir

# Update titlebars
# Modified from: https://github.com/MrElendig/dotfiles-alice/blob/master/.zshrc
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () { print -Pn "\e]0;%n@%M: %2~\a" }
    preexec () { print -Pn "\e]0;%n@%M: %2~\a" }
    ;;
esac

# Colored man pages
man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

#=====================
# Key bindings
#=====================
bindkey -v # Vim keybindings

# 0.1s delay between mode changes
export KEYTIMEOUT=1

# Incremental search with up/down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey -M vicmd 'k' up-line-or-search
bindkey -M vicmd 'j' down-line-or-search

#=====================
# Prompt
#=====================
# Perform substitutions within prompts
setopt prompt_subst
source $HOME/.zsh/custom-prompt.zsh

#=====================
# Completion
#=====================
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Complete PIDs with menu selection
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# Remove trailing slash for directory arguments
zstyle ':completion:*' squeeze-slashes true

autoload -Uz compinit && compinit

# Autocomplete zsh scripts based on gnu --help
compdef _gnu_generic $HOME/scripts/zsh/*

# Fill in .. when going up directories
# Source: zsh-lovers
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

#=====================
# Custom Bash Completions
#=====================
# Handle bash completion
autoload -Uz bashcompinit && bashcompinit

source $HOME/.bash_completion.d/scripts-completion

#=====================
# History
#=====================
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

setopt appendhistory # Append to history file instead of overwriting
setopt hist_ignore_dups # Don't store sequential dups
setopt hist_expire_dups_first # Remove dups before other entries when trimming
setopt hist_reduce_blanks # Remove superfluous blanks from commands
#setopt hist_save_no_dups # Don't save any duplicates at all when writing history file
setopt hist_verify # Expand history expansions before executing
#setopt inc_append_history # Add new lines incrementally instead of on exit

#=====================
# Path additions
#=====================
# If created as a copy of an interactive shell, don't add to path again
# BROWSER is a nonstandard variable set later in this file
if [[ -z "$BROWSER" ]]; then
  PATH=$PATH:$HOME/scripts/zsh # Zsh scripts with same name take priority
  PATH=$PATH:$HOME/scripts/bash
  export PATH
fi

#=====================
# Variable Exports
#=====================
export ANDROID_HOME=/opt/android-sdk
export BROWSER=firefox
export EDITOR=vim
export PYTHONSTARTUP="$HOME/.config/python/pythonrc"

#=====================
# Aliases
#=====================
# Coloring Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Other aliases
alias config='/usr/bin/git --git-dir=$HOME/.config_store/ --work-tree=$HOME' # Dotfile version control
alias feh='feh --auto-zoom --scale-down' # Adjust size for tiled windows
alias l='ls'
alias la='ls -A' # Convenient for listing hidden files
alias ll='ls -alh' # Convenient for long listings
alias less='less -x4' # Set tab stop to 4
alias open='xdg-open'
alias view='vim -R'
alias vimu="vim --cmd ':let g:Persistent_Undo_Off=1'" # Run vim without persistent undo
alias vimy="vim --cmd ':let g:YCM_On=1'" # Run vim with auto completer on
alias vimscratch="vimu /tmp/scratch_files/`date +%F_%H-%M-%S` --noplugin -c 'syntax off' -c 'set noswapfile'"

#=====================
# External Functions
#=====================
# Remove duplicates while preserving input order
# See #43 @ http://www.catonmat.net/blog/awk-one-liners-explained-part-one/
dedupe () {
   awk '! x[$0]++' $@
}

# Create directories and cd into the first one
mkcd () {
  mkdir -p $@ && cd "$1"
}

# Create a new shell in the same directory
# and dissociate it from the parent process.
new () {
  # Runs as a substitution to avoid the
  # 'sent to background' + job id output
  `nohup termite &>/dev/null&`
}
