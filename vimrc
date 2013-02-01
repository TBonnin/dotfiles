silent! call pathogen#infect()
silent! call pathogen#helptags()

set nocompatible

set number
set ruler
syntax on

set ttyfast

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

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n nzzzv:call PulseCursorLine()<cr>
nnoremap N Nzzzv:call PulseCursorLine()<cr>

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

"Command-T configuration
"let g:CommandTMaxHeight=20
"let g:CommandTAcceptSelectionMap = '<C-t>'
"let g:CommandTAcceptSelectionTabMap = '<CR>'

"map <Leader>y :CommandTTag<CR>
"imap <Leader>y <Esc>:CommandTTag<CR>

"ZoomWin configuration
"map <Leader><Leader> :ZoomWin<CR>

" Powerline
set t_Co=256
let g:Powerline_symbols = 'fancy'

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" CTags
map <C-\> :tnext<CR>

" Easytags
:let g:easytags_cmd = '/usr/local/bin/ctags'
:set tags=./.tags,.tags;
":let g:easytags_dynamic_files = 2

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

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

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color Tomorrow-Night

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" when you forgot to sudo before editing a file that requires root privileges
" (typically /etc/hosts). This lets you use w!! to do that after you opened
" the file already
cmap w!! w !sudo tee % >/dev/null 

" DelimitMate
let delimitMate_expand_cr = 1
let delimitMate_balance_matchpairs = 1

" Supertab
" CrMapping = 0 to avoid conflict with DelimitMate
let g:SuperTabCrMapping = 0

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"-------------------------------------------------------------------
function! PulseCursorLine()
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#2a2a2a ctermbg=233
    redraw
    sleep 20m

    hi CursorLine guibg=#333333 ctermbg=235
    redraw
    sleep 20m

    hi CursorLine guibg=#3a3a3a ctermbg=237
    redraw
    sleep 20m

    hi CursorLine guibg=#444444 ctermbg=239
    redraw
    sleep 20m

    hi CursorLine guibg=#3a3a3a ctermbg=237
    redraw
    sleep 20m

    hi CursorLine guibg=#333333 ctermbg=235
    redraw
    sleep 20m

    hi CursorLine guibg=#2a2a2a ctermbg=233
    redraw
    sleep 20m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction

"-------------------------------------------------------------------
function! s:setupMarkup()
    nnoremap <leader>p :silent !open -a Mou.app '%:p'<cr>
endfunction

au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
