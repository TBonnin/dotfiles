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

" Move up and down DISPLAYED line
nnoremap k gk
nnoremap j gj

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
  Plug 'neovim/nvim-lspconfig' " Collection of common configurations for the Nvim LSP client
  Plug 'tjdevries/lsp_extensions.nvim' " Extensions to built-in LSP, for example, providing type inlay hints
  Plug 'nvim-lua/completion-nvim' " Autocompletion framework for built-in LSP
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
call plug#end()

" theme
set background=dark
colorscheme palenight

augroup auto_checktime
  autocmd!
  " Notify if file is changed outside of vim
  " Trigger `checktime` when files changes on disk
  " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
  " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
augroup END
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

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

" fzf
set rtp+=/usr/local/opt/fzf

let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 1.0 } }

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

if has('nvim')
  " Set completeopt to have a better completion experience
  " :help completeopt
  " menuone: popup even when there's only one match
  " noinsert: Do not insert text until a selection is made
  " noselect: Do not select, force user to select one from the menu
  set completeopt=menuone,noinsert,noselect

  " Avoid showing extra messages when using completion
  set shortmess+=c

  " Configure LSP
  " https://github.com/neovim/nvim-lspconfig
  lua <<EOF

  local nvim_lsp = require'lspconfig'

  local on_attach = function(client)
    require'completion'.on_attach(client)
  end

  nvim_lsp.rust_analyzer.setup{on_attach=on_attach}

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = {
        spacing = 4,
        prefix = '~',
      },
      signs = true,
      update_in_insert = false,
    }
  )
EOF

  " Trigger completion with <Tab>
  inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ completion#trigger_completion()

  function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  " Code navigation shortcuts
  nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> T <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> rn <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

  command! Format :lua vim.lsp.buf.formatting()

"  nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"  nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"  nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"  nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
"  nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"  nnoremap <silent> ge    <cmd>lua vim.lsp.buf.declaration()<CR>

  " have a fixed column for the diagnostics to appear in
  " this removes the jitter when warnings/errors flow in
  set signcolumn=yes

  sign define LspDiagnosticsSignError text=🔴
  sign define LspDiagnosticsSignWarning text=🟠
  sign define LspDiagnosticsSignInformation text=🔵
  sign define LspDiagnosticsSignHint text=🟢
  " Errors in Red
  hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
  " Warnings in Yellow
  hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
  " Info and Hints in White
  hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
  hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White

  " Enable type inlay hints
  autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
  \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

    " Auto-format python files prior to saving them
  autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)

endif
