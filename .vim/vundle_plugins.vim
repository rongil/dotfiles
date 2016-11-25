set nocompatible              "Be iMproved, required
filetype off                  "Required

"Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/syntastic' "Syntax checker
Plugin 'Raimondi/delimitMate' "Match parentheses
Plugin 'ervandew/supertab' "Tab completion
Plugin 'scrooloose/nerdcommenter' "Comment out lines
Plugin 'airblade/vim-gitgutter' "Git diffs in gutter
Plugin 'ryanoasis/vim-devicons' "Icons
Plugin 'vim-airline/vim-airline' "Status bar
Plugin 'vim-airline/vim-airline-themes' "Status bar themes
Plugin 'scrooloose/nerdtree' "Improved filesystem tree
Plugin 'Xuyuanp/nerdtree-git-plugin' "NERD Tree git symbols
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight' "Nerd Tree file symbols
Plugin 'sjl/gundo.vim' "Undo tree
Plugin 'wting/gitsessions.vim' "Git session save
Plugin 'ctrlpvim/ctrlp.vim' "Fuzzy file finder
Plugin 'valloric/MatchTagAlways' "Highlight HTML/XML tags
Plugin 'ternjs/tern_for_vim' "Tern JS
Plugin 'jrozner/vim-antlr' "Antlr 3+4 syntax
Plugin 'fatih/vim-go' "Go syntax, autocomplete, etc.
Plugin 'pangloss/vim-javascript' "Better JS syntax + indentation
Plugin 'heavenshell/vim-jsdoc' "JSDoc creator
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'tpope/vim-endwise' "End functions/structures automatically
Plugin 'tpope/vim-ragtag' "Tag manipulation mappings (e.g. in HTML, XML, etc.)
Plugin 'tpope/vim-repeat' "Repeat plugin commands with .
Plugin 'tpope/vim-surround' "Surround mappings (e.g. swap quote type, parens type, etc.)

if exists('g:YCM_On')
  Plugin 'davidhalter/jedi-vim' "Python autocompletion
  "Warning: Heavy plugin!
  Plugin 'Valloric/YouCompleteMe' "Code-completion engine
endif

"All of your Plugins must be added before the following line
call vundle#end()            "Required
