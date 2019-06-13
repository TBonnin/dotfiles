" Show linenumbers
set number
set ruler

" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" show current line
set cursorline

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Turn backup off
set nobackup
set nowb
set noswapfile
set nowritebackup

" Always show the status line
set laststatus=2

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Syntax coloring
syntax on
filetype plugin indent on

" No annoying sound on errors
set noerrorbells
set vb t_vb=<Paste>

" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" python
let g:python2_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" Leader key
let mapleader = ","

" turn off highlighted results (nohlsearch) when pressing Enter. 
" just pressing n or N will turn the highlight back again 
nnoremap <cr> :noh <cr>

" exit to normal mode with 'jj'
inoremap jj <ESC>

" split line at cursor
nnoremap K i<CR><Esc>

" Kill the damned Ex mode.
nnoremap Q <nop>

" when you forgot to sudo before editing a file that requires root privileges
" (typically /etc/hosts). This lets you use w!! to do that after you opened
" the file already
cmap w!! w !sudo tee % >/dev/null 

" Use system clipboard
set clipboard=unnamed

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%

" Plugins
if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-startify'
Plug 'ervandew/supertab'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tonchis/vim-to-github'
" Scala
Plug 'derekwyatt/vim-scala'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"" Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'
Plug 'Twinside/vim-hoogle'
call plug#end()

" theme
set background=dark
colorscheme palenight

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" hindent
let g:hindent_line_length = 100
"
" Hoogle
au FileType haskell nnoremap <buffer> <Leader>h :Hoogle<CR>
au FileType haskell nnoremap <buffer> <Leader>hc :HoogleClose<CR>
au FileType haskell nnoremap <buffer> <Leader>hi :HoogleInfo<CR>

" Scala
au BufRead,BufNewFile *.sbt set filetype=scala

" coc

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Better display for messages
set cmdheight=2

" Use <c-space> for trigger completion.
inoremap <silent><expr> <leader>r coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>

" Use K for show documentation in preview window
nnoremap <silent> T :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"NERDTree
nnoremap <leader>n :NERDTreeFind<CR>

" CtrlSF
nmap     <c-o>f <Plug>CtrlSFCwordPath
vmap     <c-o>f <Plug>CtrlSFVwordExec
nmap     <c-o>s <Plug>CtrlSFPrompt
nmap     <c-o>p <Plug>CtrlSFPwordPath
nnoremap <c-o>o :CtrlSFOpen<CR>
nnoremap <c-o>t :CtrlSFToggle<CR>
inoremap <c-o>t <Esc>:CtrlSFToggle<CR>

let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
let g:ctrlsf_case_sensitive = 'no'
let g:ctrlsf_default_view_mode = 'normal'
