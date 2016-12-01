# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

autoload -Uz compinit && compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch hist_ignore_dups
unsetopt beep notify
# End of lines configured by zsh-newuser-install

autoload -Uz colors && colors
autoload -Uz vcs_info

# Update titlebars
chpwd() {
  [[ -t 1 ]] || return
  case $TERM in
    sun-cmd) print -Pn "\e]l%~\e\\"
      ;;
    *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;${USER}@${HOST}: %~\a"
      ;;
  esac
}
cd .

PROMPT='%F{red}%n%f@%F{blue}%m%f %F{green}%1~%f %# '

# Git prompt
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats "%{$fg_bold[yellow]%}[%b]%{$reset_color%}"

# Source: https://dougblack.io/words/zsh-vi-mode.html
bindkey -v
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[white]%} [% NORMAL]%  %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}\$vcs_info_msg_0_$EPS1"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# Incremental search with up/down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Path additions
# If created as a copy of an interactive shell, don't add to path again
# BROWSER is a nonstandard variable set in this file
if [[ $BROWSER == "" ]]; then
  PATH=$PATH:$HOME/scripts
  export PATH
fi

# TODO: Convert to zsh completion
# Custom user completions
#source $HOME/.bash_completion.d/scripts-completion

# Variable exports
export ANDROID_HOME=/opt/android-sdk
export BROWSER=firefox
export EDITOR=vim
export PYTHONSTARTUP="$HOME/.config/python/pythonrc"

# Coloring Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Other aliases
alias config='/usr/bin/git --git-dir=$HOME/.config_store/ --work-tree=$HOME' # Dotfile version control
alias feh='feh --auto-zoom --scale-down' # Adjust size for tiled windows
alias l='ls'
alias la='ls -A' # Convenient for listing hidden files
alias ll='ls -alh' # Convenient for long listings
alias open='xdg-open'
alias view='vim -R'
alias vimu="vim --cmd ':let g:Persistent_Undo_Off=1'" # Run vim without persistent undo
alias vimy="vim --cmd ':let g:YCM_On=1'" # Run vim with auto completer on
alias vimscratch="vimu /tmp/scratch_files/`date +%F_%H-%M-%S` --noplugin -c 'syntax off' -c 'set noswapfile'"

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
