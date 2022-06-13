" ============================================================================
" VIM CONFIGURATION FILE
"
" Author:  Michaël van Diemen
" License: Public Domain

filetype off

call plug#begin('~/.local/share/nvim/plugged')

Plug 'mileszs/ack.vim'
Plug 'sgur/vim-editorconfig'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'jremmen/vim-ripgrep'
Plug 'yggdroot/indentline'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/tcomment'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
" optional for icon support
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}

Plug 'enricobacis/vim-airline-clock'

" Color schemes
Plug 'https://gitlab.com/yorickpeterse/vim-paper.git'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-two-firewatch'
Plug 'joshdick/onedark.vim'
Plug 'haishanh/night-owl.vim'
Plug 'morhetz/gruvbox'
Plug 'ntk148v/vim-horizon'

" Languages
Plug 'sheerun/vim-polyglot'
Plug 'dag/vim-fish'
Plug 'elixir-editors/vim-elixir'

call plug#end()

filetype plugin indent on
syntax on

" ============================================================================
" GENERAL SETTINGS
"

set termguicolors
set shell=sh
set nolazyredraw
set showcmd
set hid
set clipboard+=unnamedplus
set mouse=a
set history=100
set nocursorcolumn
set nocursorline
set shortmess+=A    " Hackityhacky no swapfile warnings
set guioptions=aemc " Do not show GUI Messages & Remove scroll bars
set signcolumn=yes  " Git Gutter settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set tw=120
set wrap linebreak
set autoread


" ===========================================================================
" SYNTAX SETTINGS
"
" Settings related to configuring the syntax features of Vim such as the text
" width, what theme to use and so on.
"
set textwidth=120
" set nowrap
set number
set synmaxcol=400
set colorcolumn=80
set colorcolumn+=120
set smartindent
set autoindent
set background=dark
let ayucolor="mirage"
colorscheme two-firewatch
let g:two_firewatch_italics=1

let g:python3_host_prog = '/usr/bin/python3'

let g:coc_node_path = '/home/michael/.asdf/shims/node'

" ============================================================================
" FZF
"

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" Indent line character
let g:indentLine_char = '|'
let g:indentLine_first_char = '¦'
let g:indentLine_showFirstIndentLevel = 1

" Colorscheme stuff
let g:vim_json_syntax_conceal = 0
let g:two_firewatch_italics   = 1
let g:alchemist_tag_disable   = 1
let g:rainbow_active          = 0
let g:gruvbox_contrast_dark   = 'dark'

highlight clear SignColumn

" NERDTree settings
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore     = ['\.pyc$', '\.pyo$', '__pycache__', '\.DS_Store', '\.swo$', '\.swp$', '\.keep']
let g:NERDTreeWinSize    = 30

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Airline/Powerline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='twofirewatch'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_disable_statusline = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" ============================================================================
" CUSTOM FUNCTIONS
"
" A collection of custom functions such as a function used for trimming
" trailing whitespace or converting a file's encoding to UTF-8.

" Removes trailing whitespace from the current buffer.
function! Trim()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//eg
  call cursor(l, c)
:endfunction

" ============================================================================
" HOOKS
"
" Collection of various hooks that have to be executed when a certain filetype
" is set or action is executed.

" Automatically strip trailing whitespace.
autocmd! BufWritePre * :call Trim()
autocmd BufWritePost *.ex silent !mix format <afile>
autocmd BufWritePost *.exs silent !mix format <afile>

" Set a few filetypes for some uncommon extensions
au BufRead,BufNewFile *.md     setf markdown
au BufRead,BufNewFile Gemfile  setf ruby
au BufRead,BufNewFile *.rake   setf ruby
au BufRead,BufNewFile *.ru     setf ruby
au BufNewFile,BufRead *.liquid setf liquid

" Taken from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
au BufWinEnter * match Visual /\s\+$/
au InsertEnter * match Visual /\s\+\%#\@<!$/
au InsertLeave * match Visual /\s\+$/
au BufWinLeave * call clearmatches()

" Use 2 spaces per indentation level for Ruby, YAML and Vim script.
au FileType glixir setlocal sw=2 sts=2 ts=2 expandtab
au FileType ruby   setlocal sw=2 sts=2 ts=2 expandtab
au FileType eruby  setlocal sw=2 sts=2 ts=2 expandtab
au FileType yaml   setlocal sw=2 sts=2 ts=2 expandtab
au FileType coffee setlocal sw=2 sts=2 ts=2 expandtab
au FileType liquid setlocal sw=2 sts=2 ts=2 expandtab

" ============================================================================
" KEY BINDINGS
"
" A collection of custom key bindings.
"
map <F5> :SyntasticCheck<CR><Esc>
map <F6> :NERDTreeToggle<CR><Esc>
map <F7> :GitGutterLineHighlightsToggle<CR><Esc>
map <F8> :Gblame<space>w<CR><Esc>


nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>
nnoremap \ :Rg -g '!.git'<SPACE>
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

nnoremap :Wq :wq
nnoremap :WQ :wq
nnoremap :W :w
nnoremap :Q :q

" ElixirLS / COC bindings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

noremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>

" Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ============================================================================
" NVIM SPECIFICS
"
if !has('nvim')
  set ttymouse=xterm2
  nnoremap <silent> <C-p> :FZF<CR>
endif

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  nnoremap <silent> <C-p> :FZF<CR>
  tnoremap <Esc> <C-\><C-n>
endif

if has('unix')
  let s:uname = system("uname")
endif
