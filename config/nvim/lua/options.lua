vim.cmd 'colorscheme material'

vim.o.errorbells = false

vim.o.termguicolors = true
vim.o.syntax = 'on'

vim.o.backup = false
vim.o.hidden = true
vim.bo.swapfile = false

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.completeopt = 'menuone,noinsert,noselect'
vim.opt_global.shortmess:remove("F"):append("c")

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true
vim.bo.autoindent = true
vim.bo.smartindent = true

vim.wo.number = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = true

vim.o.mouse = 'a'

vim.g.mapleader = ','
vim.g.auto_save = true
