" Show linenumbers
set number
set ruler

" Set Proper Tabs
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

" show current line
set cursorline

" highlight matching bracket
set showmatch matchtime=3

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

" yaml
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent foldlevel=10

" python
let g:python2_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" golang
autocmd Filetype go setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab

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
" set clipboard=unnamed

" Return to last edit position when opening files
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
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-startify'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'tonchis/vim-to-github'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Scala
Plug 'derekwyatt/vim-scala'
"" Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'
Plug 'Twinside/vim-hoogle'
"" Rust
Plug 'rust-lang/rust.vim'
call plug#end()

" theme
set background=dark
colorscheme palenight

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" hindent
let g:hindent_line_length = 100

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

" CoC
inoremap <sileft><expr> <leader>rf coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>a <Plug>(coc-codeaction)

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use T for show documentation in preview window
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
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Show all diagnostics
nnoremap <silent> <leader>d  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>t  :<C-u>CocListResume<CR>

command! ScalaImport :call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'build-import' }) 

:"NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
function NerdTreeToggleAndFind()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction
nnoremap <leader>n :call NerdTreeToggleAndFind()<CR>
" do not open buffer in NERDTree window
au BufEnter * if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && winnr('$') > 1 | b# | exe "normal! \<c-w>\<c-w>" | :blast | endif

" fzf
set rtp+=/usr/local/opt/fzf

let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(&lines * 0.7)
  let width = float2nr(&columns * 0.8)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = float2nr((&lines - height) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction


command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <leader>f :Rg<CR>
nnoremap <leader>s :Rg <C-R><C-W><CR>
nnoremap <leader>t :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History:<CR>
