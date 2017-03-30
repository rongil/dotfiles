" Sourced files (for modularity)
source $HOME/.config/nvim/helpers.vim
source $HOME/.config/nvim/plugins.vim

" Catch all augroup
augroup general
  autocmd!
augroup END

" General Options {{{
"==============================================================================
set encoding=utf8
if !exists('g:syntax_on') "Don't source script again if not necessary
  syntax enable  "Enable syntax highlighting
endif
filetype plugin indent on "Enable file type detection

set wildmenu "Improved tab completion
set splitright "Opens new vertical window on right
set splitbelow "Opens new horizontal window under

"Remove trailing whitespace on save (\v forces very magic, e flag silences errors)
autocmd general BufWritePre * :%s/\v\s+$//e

set mouse=a "Enable use of the mouse for all modes (already enabled by term emulator)
set visualbell t_vb= "Don't ring or flash bell
set lazyredraw "Don't redraw while performing untyped commands (e.g. macros)

"X window clipboard (without storing in clipboard unless + register specified)
set clipboard=unnamed

"Delete comment character when joining commented lines
set formatoptions+=j

"}}}
" Line Numbering {{{
"==============================================================================
set number "Line numbers
set relativenumber "Relative line numbers
"Toggle relative numbers, adapted from:
"jeetworks.org/from-acolyte-to-adept-the-next-step-after-nop-ing-arrow-keys/
augroup toggle_relativenumber
  autocmd!
  autocmd FocusGained *
        \ if &number |
        \   set relativenumber |
        \ endif
  autocmd FocusLost *
        \ if &number |
        \   set norelativenumber |
        \ endif
  autocmd InsertEnter *
        \ if &number |
        \   set norelativenumber |
        \ endif
  autocmd InsertLeave *
        \ if &number |
        \   set relativenumber |
        \ endif
  autocmd VimEnter *
        \ if &number |
        \   set relativenumber |
        \ endif
  autocmd VimLeave *
        \ if &number |
        \   set norelativenumber |
        \ endif
  autocmd WinEnter *
        \ if &number |
        \   set relativenumber |
        \ endif
  autocmd WinLeave *
        \ if &number |
        \   set norelativenumber |
        \ endif
augroup END

" }}}
" Swap File Settings {{{
"==============================================================================
"Only have swap file if file is currently in modified state
"Source: http://vi.stackexchange.com/a/69
autocmd general CursorHold,BufWritePost,BufReadPost,BufLeave *
      \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

" }}}
" General Mappings {{{
"==============================================================================
"Default is yy unlike for C and D
map Y y$

"Have uppercase with same effect
command WQ wq
command Wq wq
command W w
command Q q

"<C-L> (redraw screen) also turns off search highlight until the next search
nnoremap <C-L> :nohl<CR><C-L>

"Split lines (opposite of J)
"Source: http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
nnoremap K ciW<CR><Esc>:if match( @", "^\\s*$") < 0<Bar>exec "norm P-$diw+"<Bar>endif<CR>

" }}}
" Indentation {{{
"==============================================================================
"Default Indent
set autoindent
set smartindent
set expandtab "Use spaces instead of tabs
set shiftwidth=2 softtabstop=2 tabstop=2

"Custom Indents
autocmd general Filetype lua setlocal sw=4 sts=4 ts=4
autocmd general Filetype python setlocal sw=4 sts=4 ts=4

" }}}
" Folding {{{
"==============================================================================
set foldmethod=indent "Sets folds based on indent by default
set foldnestmax=2 "Max nesting level

" }}}
" Spell Check {{{
"==============================================================================
set spelllang=en_us
autocmd general Filetype gitcommit,markdown,tex,text
      \ if !&readonly | set spell | endif

" }}}
" Color Settings {{{
"==============================================================================
"Color Scheme
"colorscheme base
"colorscheme blackboard
"colorscheme distinguished
"colorscheme fahrenheit
"colorscheme gotham
"colorscheme gotham256
"colorscheme grb256
colorscheme jellybeans
"colorscheme molokai
"colorscheme sunburst
"colorscheme wombat256mod

"Transparent background on terminal
hi Normal ctermbg=NONE

" }}}
" Text Modification {{{
" Source: http://vim.wikia.com/wiki/Create_underlines,_overlines,_and_strikethroughs_using_combining_characters
"==============================================================================
" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

vnoremap  :Strikethrough<CR>
vnoremap __ :Underline<CR>

" }}}
" Persistent Undo {{{
"==============================================================================
set undolevels=1000 "Maximum number of changes that can be undone
set undoreload=10000 "Maximum number lines to save for undo on a buffer reload

" Don't keep persistent history if root-owned file or temp file
augroup persistent_undo
  autocmd!
  autocmd BufEnter,BufRead * if !CheckIfRootOrTemp() &&
        \ !exists('g:persistent_undo_off') | set undofile | endif
augroup END

" }}}
" Special syntax {{{
"==============================================================================
augroup special_filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.bsv set filetype=bsv
  autocmd BufNewFile,BufRead *.ejs set filetype=html
  autocmd BufNewFile,BufRead *.ll  set filetype=llvm
augroup END

" }}}
" Latex {{{
"==============================================================================
let g:vimtex_fold_enabled = 1
let g:vimtex_view_method = 'zathura'
let g:vimtex_latexmk_build_dir = 'build'

let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-f>"
let g:UltiSnipsJumpBackwardTrigger="<C-d>"

"}}}
" Deoplete {{{
"==============================================================================
let g:deoplete#enable_at_startup = 1

set completeopt=longest,menuone,preview

let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" Omnifuncs
if !exists('g:deoplete#omni#functions')
  let g:deoplete#omni#functions = {}
endif
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

" Patterns
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = '\\(?:'
      \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
      \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
      \ . '|hyperref\s*\[[^]]*'
      \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
      \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|usepackage(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|documentclass(\s*\[[^]]*\])?\s*\{[^}]*'
      \ .')'

"}}}
" Neomake {{{
"==============================================================================
autocmd general BufWritePost * Neomake

" }}}
" PySolve {{{
"==============================================================================
imap <silent> <F3> <C-O>:call PySolve(0)<CR>

" }}}
" Vim-Go {{{
"==============================================================================
let g:go_fmt_autosave = 1 "Closes all folds due to buffer rewrite
let g:go_bin_path = expand('~/.local/share/nvim/go')

" }}}
" SplitJoin {{{
"==============================================================================
let g:splitjoin_split_mapping = 'gK'
let g:splitjoin_join_mapping = 'gJ'

" }}}
" Silver Surfer (Faster search) {{{
" Source: https://robots.thoughtbot.com/faster-grepping-in-vim
"==============================================================================
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" }}}
" Ragtag {{{
"==============================================================================
let g:ragtag_global_maps = 1 "Use provided default mappings

" }}}
" NERD Commenter {{{
"==============================================================================
map gc <plug>NERDCommenterToggle

"Don't create default mappings
let g:NERDCreateDefaultMappings = 0

"Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

"Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

"Set a language to use its alternate delimiters by default
let g:NERDAltDelims_c = 1 "Use // instead of /**/
let g:NERDAltDelims_cpp = 1

"Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

"Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" }}}
" NERD Tree {{{
"==============================================================================
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

noremap <C-n> :NERDTreeToggle<CR>

" Close NERD Tree if last window
augroup NERDTree
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " Open NERD Tree if no files specified
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

" }}}
" Mundo Undo Tree (Gundo fork) {{{
"==============================================================================
nnoremap <F5> :MundoToggle<CR>

" }}}
" Airline Status bar {{{
"==============================================================================
set laststatus=2 "Always show statusline
let g:airline_powerline_fonts=1 "Populate airline symbols dict
let g:airline_theme='jellybeans'

"Smarter tab line (show buffers when there's only one tab)
let g:airline#extensions#tabline#enabled=1

" }}}

" vim:foldmethod=marker:foldlevel=0
