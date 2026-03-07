vim.o.termguicolors = true
vim.o.showtabline = 0
vim.o.backup = false
vim.o.swapfile = false
vim.o.autowriteall = true

vim.o.laststatus = 3
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.cursorline = true
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.completeopt = "menuone,noinsert,noselect"

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.scrolloff = 7
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = true

vim.g.mapleader = ","
vim.g.auto_save = true

vim.o.updatetime = 200

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	command = "setlocal nonumber norelativenumber | setfiletype terminal | startinsert",
})
vim.api.nvim_create_autocmd("TermClose", { pattern = "*", command = "bd!" })
