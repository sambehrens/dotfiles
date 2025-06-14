" Install plug.vim plugin manager if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugin manager
" see mappings below 
call plug#begin('~/.vim/plugged')

" color scheme
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'cormacrelf/vim-colors-github'
Plug 'devsjc/vim-jb'

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

" better syntax highlighting and indentation
Plug 'sheerun/vim-polyglot'

" better file explorer
Plug 'tpope/vim-vinegar'

" Git inside vim
Plug 'tpope/vim-fugitive'

" Browse gitlab from vim fugitive
Plug 'shumphrey/fugitive-gitlab.vim'

" Syntax highlighting for sailfish templates, used by fast-giftgo
Plug 'rust-sailfish/sailfish', { 'rtp': 'syntax/vim' }

" typescript styntax stuff
" Plug 'leafgarland/typescript-vim'

" Surround words and phrases with stuff ('[etc.]')
Plug 'tpope/vim-surround'

" Get a better autocomplete window
Plug 'gelguy/wilder.nvim'

call plug#end()

" Change cursor shape between insert and normal mode in iTerm2.app
" if $TERM_PROGRAM =~ "iTerm"
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
" endif

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
map! ;; <Esc> " map ;; to Esc

" turn off swapfiles because they suck
set noswapfile

syntax on
" Set mdx syntax because it doesn't seem to work
au BufReadPost *.mdx set filetype=mdx
" Use new regular expression engine
set re=0

" automatically reload file when changes happen outside
set autoread
" automatically write when you move to a different file/buffer
set autowriteall
:au FocusLost * silent! wa

" default updatetime 4000ms is not good for async update
set updatetime=100

" Set keycode delays to 0 so CTRL-[ updates immediately
" default timeoutlen is 1000
set timeoutlen=500 ttimeoutlen=0

set nocompatible

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

" Move cursor to word when searching
set incsearch

" Enable the enhanced completion thing for commands
" set wildmenu
" set wop=fuzzy,pum

" Ignore case when searching unless search contains uppercase
set ignorecase
set smartcase

" Of course I want to be able to use a mouse!
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Copy to system clipboard with yank
set clipboard=unnamed

" Color the 80, 100 column light grey
set colorcolumn=80,100
" highlight ColorColumn ctermbg=0 guibg=lightgrey

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

" File type specific tab sizes
autocmd FileType rust setlocal shiftwidth=4 softtabstop=4
autocmd FileType python setlocal shiftwidth=4 softtabstop=4

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" this makes it so indents don't go away when I leave a line
nnoremap o ox<BS>
nnoremap O Ox<BS>

" Leader key stuff
" Set leader key to Space
let mapleader =  " "

" Templates
autocmd FileType javascript imap <buffer> ;log console.log(
autocmd FileType typescript imap <buffer> ;log console.log(
autocmd FileType typescriptreact imap <buffer> ;log console.log(
autocmd FileType javascriptreact imap <buffer> ;log console.log(
autocmd FileType typescriptreact imap <buffer> ;rc console.log(
autocmd FileType javascriptreact imap <buffer> ;rc console.log(
autocmd FileType java imap <buffer> ;log System.out.println(
" Auto insert react component boiler plate
function! CreateReactComponent()
    call inputsave()
    let componentName = input('Component name: ')
    call inputrestore()
    execute "normal! itype " . componentName . "Props = {\n \n}\n\nexport function " . componentName . "(props: " . componentName . "Props) {\n \n}\n"
    execute "normal! 2k 2l"
endfunction
autocmd FileType typescriptreact nnoremap <leader>rc :call CreateReactComponent()<CR>
autocmd FileType javascriptreact nnoremap <leader>rc :call CreateReactComponent()<CR>
autocmd FileType rust imap <buffer> ;log println!("

" Coc stuff
" Coc Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Coc do code action
" Applying codeAction to the selected region.
" Note the 'j' is to make the hint window go away
xmap <leader>do <Plug>(coc-codeaction-cursor)
nmap <leader>do <Plug>(coc-codeaction-cursor)
vmap <leader>do <Plug>(coc-codeaction-cursor)
" Makes Alt + Enter do codeaction like IntelliJ
" Make sure to set Left Option to Esc+ in iTerm for this to work
xnoremap <Esc><CR> <Plug>(coc-codeaction-cursor)
vnoremap <Esc><CR> <Plug>(coc-codeaction-cursor)
nnoremap <Esc><CR> <Plug>(coc-codeaction-cursor)

"" Coc window navigation
" Navigate the popup menu using <C-j> and <C-k>
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

" Only map <C-j> and <C-k> in normal mode for CoC if PUM is visible
nnoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
nnoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"

" Avoid conflicts with other mappings
if !has('ide')
  inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
endif
" inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<CR>x\<BS>"

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
nnoremap gff :CocCommand git.browserOpen<CR>
" End Coc Stuff

" Vim fugitive
nnoremap <leader>fr :Gvdiffsplit!<CR>
nnoremap <leader>fd :Gdiffsplit<CR>
nnoremap <leader>fw :Gwrite<CR>
nnoremap <leader>fx :only<CR>
nnoremap <leader>dgl :diffget //2 <bar> diffupdate<CR>
nnoremap <leader>dgr :diffget //3 <bar> diffupdate<CR>

" Window navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Fix syntax highlighting for typescript template strings
nnoremap <leader>ss :syntax sync fromstart<CR>

" Quick save
nnoremap <leader>w :w<CR>

" Undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" Open directory in vertical window to the left
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" fzf
nnoremap <leader>O :Files<CR>
nnoremap <leader>o :GFiles<CR>
nnoremap <leader>i :Buffers<CR>
nnoremap <leader>u <C-^>

" Ripgrep search
nnoremap <leader>F :Rg<CR>

" close windows faster with ctrl x
nnoremap <leader>x :close<CR>

" rust stuff
nnoremap <leader>cr :Crun<CR>
nnoremap <leader>cb :Cbuild<CR>
nnoremap <leader>ct :Ctest<CR>
nnoremap <leader>rf :RustFmt<CR>

" Show highlight groups at cursor
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" source vimrc so easy
nnoremap <leader>sv :source ~/.vimrc<CR>

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
    \'coc-jest',
    \'coc-elixir',
    \]
call coc#config('jest', {
    \ 'customFlags': ['--coverage=false'],
    \})

" Prettier setup
" Allows you to call :Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Run prettier
nnoremap <leader>pp :Prettier<CR>

" Jest setup
" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])
nnoremap <leader>tf :JestCurrent<CR>
" Run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

" Nerd commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
nnoremap <leader>cc :call nerdcommenter#Comment('x', 'toggle')<CR>
vnoremap <leader>cc :call nerdcommenter#Comment('x', 'toggle')<CR>

" Netrw file explorer settings
" Use a tree view
" let g:netrw_liststyle = 3
" Hide top banner
" let g:netrw_banner = 0
" Set the file explorer to 25% of the page width
" let g:netrw_winsize = 25
" Open files in vertical window
" let g:netrw_browse_split = 4

" vim fugitive (git)
" fugitive-gitlab domains
let g:fugitive_gitlab_domains = ['https://git.dataminr.com']
nnoremap <leader>gb :Git blame<CR>

" Wilder menu stuff
call wilder#setup({'modes': [':', '/', '?']})
" 'reverse'    : if 1, shows the candidates from bottom to top
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'highlights': {
      \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
      \ },
      \ 'min_width': '100%',
      \ 'max_height': '50%',
      \ 'reverse': 1,
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ })))
" Key map
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<C-k>',
      \ 'previous_key': '<C-j>',
      \ 'accept_key': '<Tab>',
      \ 'reject_key': '<C-u>',
      \ })

" Colors!
set termguicolors
set background=light
let g:airline_theme = "dark"
let g:jb_style='light'
colorscheme jb
" override the highlight color
hi Visual guibg=#b0d8ff
hi typescriptCall ctermfg=16
hi typescriptDestructureVariable ctermfg=16
hi! link vimOption Type
" Make strings green
" hi typescriptString ctermfg=28
" hi typescriptStringLiteralType ctermfg=28
" hi typescriptTemplate ctermfg=28
" hi jsxString ctermfg=28
" hi jsString ctermfg=28
" hi cssStringQ ctermfg=28
" Fix the terrible floating window that makes it so you can't read errors
" hi CocErrorFloat guifg=#585858
" hi diffRemoved ctermbg=225
" hi jsonString ctermfg=28
hi jsonKeyword ctermfg=91
" hi yamlFlowString ctermfg=28
" hi jsonKeywordMatch ctermfg=92
" hi jsonQuote ctermfg=0
" hi pythonString ctermfg=28
