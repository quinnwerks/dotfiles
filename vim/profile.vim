""""""""""""""""""""""""""""""
" Quinn's .vimrc file
" Created on: 2019-05-18
""""""""""""""""""""""""""""""

""""""""""""""""""""
" PLUGINS
""""""""""""""""""""
" Automate installation of plugin manager. Note: requires curl.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    " Colorscheme
    Plug 'tyrannicaltoucan/vim-deep-space'
    
    " Statusline 
    Plug 'itchyny/lightline.vim'
    
    " Fuzzy file finder
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    
    " Git integration
    Plug 'tpope/vim-fugitive'
    
    " Pretty git statuses on the side
    Plug 'airblade/vim-gitgutter'

    " Linting for various languages
    Plug 'dense-analysis/ale'

call plug#end()

""""""""""""""""""""
" STATUS LINE SETUP
""""""""""""""""""""
" Set bottom status bar to be 2 chars high
set laststatus=2

" Turn off crappy default status bar
set noshowmode

" Basic lightline json config
let g:lightline = {
                  \    'colorscheme': 'one',
                  \    'active': {
                  \        'left': [ [ 'mode', 'paste' ],
                  \            [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                  \     },
                  \    'component_function': {
                  \    'gitbranch': 'fugitive#head'
                  \    },
                  \}    

""""""""""""""""""""
" LINTING SETUP
""""""""""""""""""""
" Show errors in list form
let g:ale_open_list=1
" Use cargo as rust linter
let g:ale_rust_cargo_use_check=1

""""""""""""""""""""
" COLORS
""""""""""""""""""""
" Syntax highlighting on 
syntax enable

" Set colorscheme to dark
set background=dark

" Don't user term colors
set termguicolors 

" Attempt to set colorscheme
try
    colorscheme deep-space
catch
endtry

""""""""""""""""""""
" TABS
""""""""""""""""""""
" Set visual tab length
set tabstop=4

" Set tab to be defined as 4 spaces
set softtabstop=4
set shiftwidth=4

" Set tabs=spaces
set expandtab

" Smarter tabbing
set smarttab

""""""""""""""""""""
" VIM IN FILE SEARCH
""""""""""""""""""""
" Set search to be incremental
set incsearch

" Turn search highlighting on
set hlsearch

" Turn off annoying search highlighting when F2 is pressed
nnoremap <F2> :nohlsearch<CR>

""""""""""""""""""""
" CODING 
""""""""""""""""""""
" Allow line numbering to show up
set number

" Show bracket pairs
set showmatch

" Show last command entered
set showcmd

""""""""""""""""""""
" VIM UI NAVIGATION
""""""""""""""""""""
" Navigation between vim tabs
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>

" Navigation between vim windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"move vertically by visual line, not the 'real' line
nnoremap j gj
nnoremap k gk

"allow mouse to be used for window resizing
set mouse=n

