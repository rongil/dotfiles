source $HOME/.vim/helper_funcs.vim
let g:RootOrTempFile=CheckIfRootOrTemp()

source $HOME/.vim/vundle_plugins.vim

"==============================================================================
" General Options
"==============================================================================
set nocompatible "More useful instead of more compatible :)
set encoding=utf8
if !exists('g:syntax_on') "Don't source script again if not necessary
  syntax enable  "Enable syntax highlighting
endif
filetype plugin indent on "Enable file type detection

set wildmenu "Improved tab completion
set number "Line numbers
set splitright "Opens new vertical window on right
set splitbelow "Opens new horizontal window under

"Remove trailing whitespace on save (\v forces very magic, e flag silences errors)
autocmd BufWritePre * :%s/\v\s+$//e

set mouse=a "Enable use of the mouse for all modes (already enabled by term emulator)
set visualbell "Don't ring bell when doing something wrong
set t_vb= "Also don't show flash from visual bell
set lazyredraw "Don't redraw while performing untyped commands (e.g. macros)

"X window clipboard (without storing in clipboard unless + register specified)
set clipboard=unnamed

"Delete comment character when joining commented lines
set formatoptions+=j

"==============================================================================
" GUI Options (since some applications launch GVim by default)
"==============================================================================
if has('gui_running')
  set guifont=Source\ Code\ Pro\ 12
  set guioptions-=m "No menu bar
  set guioptions-=r "No right scroll bar
  set guioptions-=L "No left scroll bar
  set guioptions-=T "No toolbar
endif

"==============================================================================
" Swap File Settings
"==============================================================================
"Only have swap file if file is currently in modified state
"Source: http://vi.stackexchange.com/a/69
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

"==============================================================================
" General Mappings
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

"==============================================================================
" Indentation
"==============================================================================
"Default Indent
set autoindent
set smartindent
set expandtab "Use spaces instead of tabs
set shiftwidth=2 softtabstop=2 tabstop=2

"Custom Indents
autocmd Filetype lua setlocal sw=4 sts=4 ts=4
autocmd Filetype python setlocal sw=4 sts=4 ts=4
let b:verilog_indent_modules = 1

"Detect Indent
let g:indent_detector_echolevel_enter=0
let g:indent_detector_echolevel_write=0

"==============================================================================
" Folding
"==============================================================================
set foldmethod=indent "Sets folds based on indent by default
set foldnestmax=2 "Max nesting level

"==============================================================================
" Spell Check
"==============================================================================
set spelllang=en_us
autocmd Filetype gitcommit,markdown,tex,text if !&readonly | set spell

"==============================================================================
" Color Settings
"==============================================================================
"Color Scheme
set t_Co=256 "Use 256 colors
"set background=dark
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

"==============================================================================
" Text Modification
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

"==============================================================================
" Search
"==============================================================================
set hlsearch "Search highlighting
set incsearch "Incremental search
set magic "Regex: unescaped magic chars are magic chars (rather than literals)

"==============================================================================
" Persistent Undo
"==============================================================================
" Don't keep persistent history if root-owned file or temp file
if !g:RootOrTempFile && !exists('g:Persistent_Undo_Off')
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000 "Maximum number of changes that can be undone
  set undoreload=10000 "Maximum number lines to save for undo on a buffer reload
endif

"==============================================================================
" Special syntax
"==============================================================================
autocmd BufNewFile,BufRead *.bsv set filetype=bsv
autocmd BufNewFile,BufRead *.ejs set filetype=html

"==============================================================================
" Latex
"==============================================================================
let g:Tex_Flavor='latex'
let g:Tex_DefaultTargetFormat='pdf' "Latex compile to pdf
let g:Tex_ViewRule_pdf='zathura'
"Place auxilary files in separate folder and copy pdf to main directory
let g:Tex_CompileRule_pdf='mkdir -p build; pdflatex -output-directory build -interaction=nonstopmode $*; cp build/*.pdf .'
autocmd BufWritePost,FileWritePost *.tex silent call Tex_RunLaTeX()

"==============================================================================
" PySolve (Not through Vundle)
"==============================================================================
imap <silent> <F3> <C-O>:call PySolve(0)<CR>

"==============================================================================
" Vim-Go
"==============================================================================
"let g:go_fmt_autosave = 0 "Closes all folds due to buffer rewrite
let g:go_bin_path = expand('~/.vim/go')
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>f :<C-u>GoFmt<CR>

"==============================================================================
" Tern JS
"==============================================================================
let g:tern_show_argument_hints='on_hold'

"==============================================================================
" SplitJoin
"==============================================================================
let g:splitjoin_split_mapping = 'gK'
let g:splitjoin_join_mapping = 'gJ'

"==============================================================================
" Syntastic
"==============================================================================
let g:syntastic_always_populate_loc_list = 1 "Always fill in error list
let g:syntastic_auto_loc_list = 0 "Auto display errors list
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_compiler_options = '-std=c99 -Wall -Wextra -Wpedantic'
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall -Wextra -Wpedantic'
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

"Active mode must be activated manually (e.g. through SyntasticToggleMode)
"Reasoning: syntax check can cause huge slowdown when making quick changes
let g:syntastic_mode_map = {
\  'mode': 'passive',
\  'active_filetypes': [],
\  'passive_filetypes': ['go']
\}

"Shortcuts to toggle syntax checking on write
noremap <F2> :SyntasticToggleMode<CR>
inoremap <F2> <C-O>:SyntasticToggleMode<CR>

"==============================================================================
" MatchTagAlways
"==============================================================================
nnoremap <leader>% :MtaJumpToOtherTag<CR>

"==============================================================================
" NERD Commenter
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

"==============================================================================
" NERD Tree
"==============================================================================
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

noremap <C-n> :NERDTreeToggle<CR>

" Close NERD Tree if last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open NERD Tree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"==============================================================================
" Gundo Undo Tree
"==============================================================================
nnoremap <F5> :GundoToggle<CR>

"==============================================================================
" Airline Status bar
"==============================================================================
set laststatus=2 "Always show statusline
let g:airline_powerline_fonts=1 "Populate airline symbols dict
let g:airline_theme='jellybeans'

"Smarter tab line (show buffers when there's only one tab)
let g:airline#extensions#tabline#enabled=1
