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
    Plug 'dracula/vim'
    Plug 'itchyny/lightline.vim'
    
    " Fuzzy file finder
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    
    " Git integration
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

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
                  \    'colorscheme': 'solarized',
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
"TODO

""""""""""""""""""""
" COLORS
""""""""""""""""""""
" Syntax highlighting on 
syntax enable

" Set colorscheme to dark
set background=dark

" Assume terminal can support 256 colors.
" This isn't the 90's.
" Note: gnome terminal is really bad at dealing with this.
set t_Co=256

" Attempt to set colorscheme
try
    colorscheme dracula 
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
" Set leader key
let mapleader = "\<Space>"
" Faster quit, write, search, replace, line select`
noremap <leader>q :q<CR>
noremap <leader>w :w<CR>
noremap <leader>s /
noremap <leader>v V
noremap <leader>r :%s/

" Navigation between vim windows
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Navigation between vim tabs
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>

"move vertically by visual line, not the 'real' line
nnoremap j gj
nnoremap k gk

