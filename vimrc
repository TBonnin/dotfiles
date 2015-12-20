" required by Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin in GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/The-NERD-Commenter'
Plugin 'vim-scripts/ZoomWin'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/netrw.vim'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'davidoc/taskpaper.vim'
Plugin 'xolox/vim-misc'
Plugin 'itchyny/lightline.vim'
Plugin 'vim-scripts/Auto-Pairs'
Plugin 'ervandew/supertab'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" Watch for changes in your .vimrc and automatically reload the config.
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Leader key
let mapleader = ","

if !has('gui_running')
    set t_Co=256
endif

set number
set ruler
set cursorline
set ttyfast
syntax on

" Set encoding
set encoding=utf-8

" highlight current line in insert mode
:autocmd insertenter * set cul
:autocmd InsertLeave * set nocul

" Wrapping
:set wrap
:set linebreak
:set nolist  " list disables linebreak
:set textwidth=0
:set wrapmargin=0

" Whitespace stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set list listchars=tab:\ \ ,trail:·

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" turn off highlighted results (nohlsearch) when pressing Enter. 
" just pressing n or N will turn the highlight back again 
nnoremap <cr> :noh <cr>

" exit to normal mode with 'jj'
inoremap jj <ESC>

" split line at cursor
nnoremap K i<CR><Esc>

" Easier buffers navigation
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>nb :buffers<CR>:buffer<Space>

" make uses real tabs
au FileType make set noexpandtab

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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

" Include local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Default color scheme
color Tomorrow-Night

" Open NERDTree at startup and close vim when NERDTree is the last window open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_enable_balloons = 1
