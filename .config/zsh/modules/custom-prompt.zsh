#==============================================================================
# Themes that inspired this...
#
# (Avit Zsh Theme)
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/avit.zsh-theme
#==============================================================================
autoload -Uz colors && colors

function set_prompt {
  typeset host_string
  # Only show host on remote connections
  [[ -n `who am i` ]] && host_string='%F{blue}@%m%f'
  PROMPT="%F{red}[%n%f$host_string%F{red}%B]%b%f%f%F{green}[%2~]%f%B%F{white}▶%f%b "
}

function set_rprompt {
  typeset git_prompt
  git_prompt="$(git_prompt_info)$(git_prompt_status)"
  [[ -n $git_prompt ]] && git_prompt="%B%F{yellow}[%f%b"$git_prompt"%F{yellow}%B]%b%f"

  RPROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$git_prompt%{$reset_color%}"
}

# Git prompt
source $ZDOTDIR/modules/git.zsh
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "

# Vim prompt
# Source: https://dougblack.io/words/zsh-vi-mode.html
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[white]%}[% NORMAL]%{$reset_color%}"
  set_rprompt
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

set_prompt
set_rprompt
