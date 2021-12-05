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
" Always show sign column
" set signcolumn=yes

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

" Coc stuff
" Coc Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Coc window navigation
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Window navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Quick save
nnoremap <leader>w :w<CR>

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

" comment out stuff easily
nnoremap <leader>1 :norm ^xxx<CR>
nnoremap <leader>2 :norm I# <CR>
nnoremap <leader>3 :norm I// <CR>

" rust stuff
nnoremap <leader>cr :Crun<CR>
nnoremap <leader>rf :RustFmt<CR>

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

" syntastic syntax checking
Plug 'vim-syntastic/syntastic'

" rust official vim plugin
Plug 'rust-lang/rust.vim'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" nerd commenter so I can easily comment lines out
Plug 'preservim/nerdcommenter'

call plug#end()

" Syntastic beginner configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" coc.nvim
let g:coc_global_extensions = [
      \'coc-highlight',
      \'coc-pairs',
      \'coc-python',
      \'coc-json', 
      \'coc-rust-analyzer',
      \]

" Nerd commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Colors!
set background=light
colorscheme PaperColor
