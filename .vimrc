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
" Use all 256 colors
set t_Co=256
"
" default updatetime 4000ms is not good for async update
set updatetime=100

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
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
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

" close windows faster with ctrl x
nnoremap <leader>x :close<CR>

" rust stuff
nnoremap <leader>cr :Crun<CR>
nnoremap <leader>rf :RustFmt<CR>


" vim-plug plugin manager
" see mappings below 
call plug#begin('~/.vim/plugged')

" color scheme
Plug 'NLKNguyen/papercolor-theme'

" syntastic syntax checking
" Plug 'vim-syntastic/syntastic'

" rust official vim plugin
Plug 'rust-lang/rust.vim'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" nerd commenter so I can easily comment lines out
Plug 'preservim/nerdcommenter'

" airline for the bar at the bottom of vim window
Plug 'vim-airline/vim-airline'

call plug#end()

" Syntastic beginner configuration
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

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
