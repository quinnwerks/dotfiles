""""""""""""""""""""""""""""""
" Quinn's .nvimrc file
" Created on: 2020-10-26
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""
" Robust Plugin installation
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path .
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path
" List of plugins
call plug#begin('~/.config/nvim/plugins')
    " Colorschemes that I like to switch between
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'arcticicestudio/nord-vim'

    " Airline for better statuses
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Stuff for git
    Plug 'airblade/vim-gitgutter'

    " Taglist (requires ctags)
    Plug 'majutsushi/tagbar'

    " Nicer File Tree
    Plug 'scrooloose/nerdtree'

    " Linter
    "    Plug 'w0rp/ale'
call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install

""""""""""""""""""""""""""""""
" Colours
""""""""""""""""""""""""""""""
colorscheme nord
set termguicolors

""""""""""""""""""""""""""""""
" UI Tweaks
""""""""""""""""""""""""""""""
" Allow line numbering to show up
set number

" Show bracket pairs
set showmatch

let NERDTreeShowHidden=1

""""""""""""""""""""""""""""""
" Linter Setup
""""""""""""""""""""""""""""""
" TODO

""""""""""""""""""""""""""""""
" Key (Re)Mapping
""""""""""""""""""""""""""""""
let mapleader = "\<Space>"
" Faster quit, write
noremap <leader>q :q<CR>
noremap <leader>w :w<CR>

noremap <leader>t :TagbarToggle<CR>
noremap <leader>d :NERDTreeToggle<CR>

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
