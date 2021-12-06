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

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Keep the cursor away from the edge of the page
set scrolloff=4

set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set fileformat=unix

" File type specific tab sizes
autocmd FileType rust setlocal shiftwidth=4 softtabstop=4 expandtab

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
set colorcolumn=80,100
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

" Coc do code action
" Applying codeAction to the selected region.
" Note the 'j' is to make the hint window go away
xmap <leader>do <Plug>(coc-codeaction-selected)j
nmap <leader>do <Plug>(coc-codeaction-selected)j

" Coc window navigation
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
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

" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" undo chunk
nmap gu :CocCommand git.chunkUndo<CR>
" open current line in browser
nmap bo :CocCommand git.browserOpen<CR>
" End Coc Stuff

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
nnoremap <leader>o :GFiles<CR>
nnoremap <leader>i :Buffers<CR>

" Ripgrep search
nnoremap <leader>f :Rg<CR>

" close windows faster with ctrl x
nnoremap <leader>x :close<CR>

" Toggle Netrw file explorer
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
noremap <leader>e :call ToggleNetrw()<CR>

" rust stuff
nnoremap <leader>cr :Crun<CR>
nnoremap <leader>rf :RustFmt<CR>

" vim-plug plugin manager
" see mappings below 
call plug#begin('~/.vim/plugged')

" color scheme
Plug 'NLKNguyen/papercolor-theme'

" rust official vim plugin
Plug 'rust-lang/rust.vim'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" nerd commenter so I can easily comment lines out
Plug 'preservim/nerdcommenter'

" airline for the bar at the bottom of vim window
Plug 'vim-airline/vim-airline'

" Fuzzy searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Make styled-components look good
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

call plug#end()

" coc.nvim
let g:coc_global_extensions = [
      \'coc-highlight',
      \'coc-pairs',
      \'coc-git',
      \'coc-python',
      \'coc-json', 
      \'coc-rust-analyzer',
      \'coc-tsserver',
      \'coc-eslint',
      \'coc-prettier',
      \]

" Prettier setup
" Allows you to call :Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Run prettier
nnoremap <leader>p :Prettier<CR>

" Nerd commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Netrw file explorer settings
" Use a tree view
let g:netrw_liststyle = 3
" Hide top banner
let g:netrw_banner = 0
" Set the file explorer to 25% of the page width
let g:netrw_winsize = 25
" Open files in vertical window
let g:netrw_browse_split = 4

" Colors!
set background=light
colorscheme PaperColor
