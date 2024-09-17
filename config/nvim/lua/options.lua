vim.o.errorbells = false

vim.o.termguicolors = true
vim.o.syntax = "on"
-- Hide tabline even when extension like lualine overrides it
-- vim.o.showtabline = 0
vim.api.nvim_create_autocmd("BufReadPre", {
	group = vim.api.nvim_create_augroup("showtabline", { clear = true }),
	callback = function()
		vim.opt.showtabline = 0
	end,
	desc = "Hide tabline (set showtabline=0)",
})

vim.o.backup = false
vim.o.hidden = true
vim.bo.swapfile = false
vim.o.autowriteall = true

vim.o.laststatus = 3
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.cursorline = true
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.completeopt = "menuone,noinsert,noselect"

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.scrolloff = 7
vim.bo.autoindent = true
vim.bo.smartindent = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = true
vim.o.mouse = "a"

vim.g.mapleader = ","
vim.g.auto_save = true

vim.o.updatetime = 200

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	command = "setlocal nonumber norelativenumber | setfiletype terminal | startinsert",
})
vim.api.nvim_create_autocmd("TermClose", { pattern = "*", command = "bd!" })
