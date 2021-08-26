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
imap jk <Esc>
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
map! ;; <Esc> " map ;; to Esc

syntax on

" Highlight line with cursor
set cursorline
" Show line numbers
set number
set tabstop=4
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

" vim-plug plugin manager
" see mappings below 
call plug#begin('~/.vim/plugged')

" color scheme
Plug 'NLKNguyen/papercolor-theme'

call plug#end()
"
" Colors!
set background=light
colorscheme PaperColor
