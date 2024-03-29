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
    Plug 'ghifarit53/daycula-vim'
    Plug 'morhetz/gruvbox'

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
    Plug 'w0rp/ale'

    " Rust
    Plug 'rust-lang/rust.vim'
call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install

""""""""""""""""""""""""""""""
" Colours
""""""""""""""""""""""""""""""
colorscheme gruvbox
set termguicolors

""""""""""""""""""""""""""""""
" Whitespace
""""""""""""""""""""""""""""""
" Set visual tab length
set tabstop=4

" Set tab to be defined as 4 spaces
set softtabstop=4
set shiftwidth=4

" Set tabs=spaces
set expandtab

" Smarter tabbing
set smarttab

""""""""""""""""""""""""""""""
" UI Tweaks
""""""""""""""""""""""""""""""
" Allow line numbering to show up
set number

" Show bracket pairs
set showmatch

let NERDTreeShowHidden=1

" Get horizontal line where cursor is
set cursorline

" Turn off crappy status line
set noshowmode

""""""""""""""""""""""""""""""
" Linter Setup
""""""""""""""""""""""""""""""
" Turn off C/C++ linters. They don't work very well.
let g:ale_linters = {
\   'c': [], 'cpp': [],
\   'python':['pylint'],
\   'rust':['rls']
\}
let g:ale_rust_rls_executable = 'rls'
let g:ale_rust_rls_toolchain = 'stable'

" Fix code as I write :-)
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'rust':['rustfmt']
\}
let g:ale_fix_on_save = 1
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

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
