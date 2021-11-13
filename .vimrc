" Install plug.vim plugin manager if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" map jk to escape
" imap jk <Esc>
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
map! ;; <Esc> " map ;; to Esc

syntax on

" Highlight line with cursor
set cursorline

" Show line numbers
" turn relative line numbers on
set rnu nu

set tabstop=2
set expandtab
set shiftwidth=4
set smartindent
set fileformat=unix

" Move cursor to word when searching
set incsearch

" Ignore case when searching unless search contains uppercase
set ignorecase
set smartcase

" Of course I want to be able to use a mouse!
set mouse=a

" Copy to system clipboard with yank
set clipboard=unnamed

" Color the 80 column light grey
set colorcolumn=80
" highlight ColorColumn ctermbg=0 guibg=lightgrey

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

" Leader key stuff
" Set leader key to Space
let mapleader =  " "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" Open directory in vertical window to the left
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" fzf
nnoremap <leader>f :GFiles<CR>
nnoremap <C-p> ZZ<CR>
nnoremap <leader>b :Buffers<CR>

" Ripgrep search
nnoremap <leader>F :Rg<CR>

nnoremap <leader>3 :norm i# 

" Quick code shortcuts
" JS
" Insert function on next line and enter insert mode at name of function
nnoremap <leader>f ofunction () {}<Esc>i<CR><Esc>kf a
" Insert exported function on next line "..."
nnoremap <leader>ef oexport function () {}<Esc>i<CR><Esc>k2f a
" Insert arrow function at cursor
nnoremap <leader>af i() => 
" Insert arrow function with brackets
nnoremap <leader>ab i() => {}<Esc>i
" Insert arrow function with brackets and params
nnoremap <leader>ap i() => {}<Esc>6hi
" Insert event handler arrow function
nnoremap <leader>eh i(event) => 
" Inserts test i.e. test('', () => {});
nnoremap <leader>T otest('', () => {});<Esc>F}i<CR><Esc>kf'a
" Inserts const object
nnoremap <leader>c oconst  = {};<Esc>F}i<CR><Esc>kf a
" Inserts type object
nnoremap <leader>t otype  = {};<Esc>F}i<CR><Esc>kf a
" Inserts if statement
nnoremap <leader>if oif () {}<Esc>i<CR><Esc>kf(a
" Inserts an else if statement
nnoremap <leader>eif oelse if () {}<Esc>i<CR><Esc>kf(a
" Inserts an else statement
nnoremap <leader>el oelse {}<Esc>i<CR>

" vim-plug plugin manager
" see mappings below 
call plug#begin('~/.vim/plugged')

" color scheme
Plug 'NLKNguyen/papercolor-theme'

" rust official vim plugin
Plug 'rust-lang/rust.vim'

call plug#end()

" Colors!
set background=light
colorscheme PaperColor
