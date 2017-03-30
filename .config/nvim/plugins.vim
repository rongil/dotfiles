" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Syntax and Completion
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neoinclude.vim'
" C/C++
Plug 'zchee/deoplete-clang'
" Python
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" JS
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Go
Plug 'fatih/vim-go', { 'tag': '*' }
"Latex
Plug 'vim-latex/vim-latex'
" Vimscript
Plug 'Shougo/neco-vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" NERD Tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } "NERD Tree git symbols
Plug 'Xuyuanp/nerdtree-git-plugin' "NERD Tree git symbols
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "Nerd Tree file symbols
Plug 'ryanoasis/vim-devicons' "Icons

" Status Bar
Plug 'vim-airline/vim-airline' "Status bar
Plug 'vim-airline/vim-airline-themes' "Status bar themes

" Tim Pope Plugs
Plug 'tpope/vim-endwise' "End functions/structures automatically
Plug 'tpope/vim-ragtag' "Tag manipulation mappings (e.g. in HTML, XML, etc.)
Plug 'tpope/vim-repeat' "Repeat plugin commands with .
Plug 'tpope/vim-surround' "Surround mappings (e.g. swap quote type, parens type, etc.)

" Other
Plug 'ervandew/supertab' "Tab completion
Plug 'Raimondi/delimitMate' "Match parentheses
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }  "Undo tree
Plug 'ctrlpvim/ctrlp.vim' "Fuzzy file finder
Plug 'scrooloose/nerdcommenter' "Comment out lines
Plug 'jeetsukumaran/vim-indentwise' "Indent based movement
Plug 'airblade/vim-gitgutter' "Git diffs in gutter
Plug 'andrewradev/splitjoin.vim' "Switch between single/multi-line

" Initialize plugin system
call plug#end()
