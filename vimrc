set nocompatible
filetype off                  " required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
"Plugin 'xolox/vim-easytags'
Plugin 'vim-scripts/The-NERD-Commenter'
Plugin 'vim-scripts/ZoomWin'
Plugin 'scrooloose/syntastic'
Plugin 'hallison/vim-markdown'
Plugin 'vim-scripts/netrw.vim'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'davidoc/taskpaper.vim'
Plugin 'xolox/vim-misc'
Plugin 'itchyny/lightline.vim'
Plugin 'vim-scripts/Auto-Pairs'
Plugin 'ervandew/supertab'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

if !has('gui_running')
    set t_Co=256
endif

set number
set ruler
set cursorline
syntax on

set ttyfast

" Watch for changes in your .vimrc and automatically reload the config.

" highlight current line in insert mode
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" Leader key
let mapleader = ","

" Set encoding
set encoding=utf-8

" exit to normal mode with 'jj'
inoremap jj <ESC>

" split line at cursor
nnoremap K i<CR><Esc>

" Wrapping
:set wrap
:set linebreak
:set nolist  " list disables linebreak
:set textwidth=0
:set wrapmargin=0

" Whitespace stuff
" set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nmap <silent> ,/ :nohlsearch<CR>
" turn off highlighted results ( nohlsearch) when pressing enter. 
" just pressing n or N will turn the highlight back again 
nnoremap <cr> :noh <cr>

" Easier buffers navigation
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>nb :buffers<CR>:buffer<Space>

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Open NERDTree at startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Open NERDTree at startup and close vim when NERDTree is the last window open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CTags
map <C-\> :tnext<CR>

" Easytags
:let g:easytags_dynamic_files = 1


" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_enable_balloons = 1
let g:syntastic_phpcs_conf = "--standard=/home/".expand($USER)."/development/Etsyweb/tests/standards/stable-ruleset.xml"

if !exists("*s:setupMarkup")
    function s:setupMarkup()
        call s:setupWrapping()
        map <buffer> <Leader>p :Hammer<CR> 
    endfunction
endif

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript
 
" xlog file no backup, etc...
au BufRead,BufNewFile *.xlog set tw=120 nobackup noswapfile nowritebackup

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color Tomorrow-Night

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Status Line
set laststatus=2
" Show (partial) command in the status line
set showcmd

" when you forgot to sudo before editing a file that requires root privileges
" (typically /etc/hosts). This lets you use w!! to do that after you opened
" the file already
cmap w!! w !sudo tee % >/dev/null 

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

nnoremap <silent> n   nzz:call HLNext(0.4)<cr>
nnoremap <silent> N   Nzz:call HLNext(0.4)<cr>
 
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('ErrorMsg', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction
