local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local M = {}
local opt = {}

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})
	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

M.startup = function()
	map("i", "jj", "<esc>", opt)

	-- Move up and down DISPLAYED line
	map("n", "k", "gk", opt)
	map("n", "j", "gj", opt)

	-- turn off highlighted results (nohlsearch) when pressing Enter.
	-- just pressing n or N will turn the highlight back again
	-- in quickfix window, pressing Enter will jump to the error, so undefine the mapping there
	map("n", "<CR>", ":noh<CR>", opt)
	vim.api.nvim_create_autocmd("FileType", { pattern = "qf", command = [[nnoremap <buffer> <CR> <CR>]] })

	-- split line at cursor
	map("n", "K", "i<CR><esc>", opt)

	-- Kill the Ex mode and command history
	map("n", "Q", "<nop>", opt)
	map("n", "q:", "<nop>", opt)

	-- tabtab to leave terminal and go back to previous buffer
	map("t", "<TAB><TAB>", "<C-\\><C-n>", opt)

	-- open links
	map("n", "gx", ':exec "!open <cWORD>"<cr><cr>', opt)

	-- remap C-g/C-t to Tab/S-Tab to iterate through results while searching
	map("c", "<Tab>", 'getcmdtype() =~ "[/?]" ? "<C-g>" : "<C-z>"', { expr = true, silent = false })
	map("c", "<S-Tab>", 'getcmdtype() =~ "[/?]" ? "<C-t>" : "<S-Tab>"', { expr = true, silent = false })

	-- search on screen only
	map("n", "\\", "'/\\%(\\%>'.(line('w0')-1).'l\\%<'.(line('w$')+1).'l\\)\\&'", { expr = true, silent = true })
end

M.neotree = function()
	map("n", "<leader>1", ":Neotree reveal<CR>", opt)
end

M.telescope = function()
	map("n", "<leader>r", ":Telescope resume<CR>", opt)
	map("n", "<leader>f", ":Telescope live_grep<CR>", opt)
	map("n", "<leader>t", ":Telescope find_files <CR>", opt)
	map(
		"n",
		"<leader>o",
		':lua require("telescope.builtin").oldfiles({ sort_mru = true, ignore_current_buffer = true })<CR>',
		opt
	)
	map(
		"n",
		"<leader>w",
		':lua require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })<CR>',
		opt
	)
	map("n", "<leader>c", ":Telescope command_history<CR>", opt)
	map("n", "<leader>e", ":Telescope diagnostics<CR>", opt)
	map("n", "<leader>q", ":Telescope quickfix<CR>", opt)
	map("n", "<leader>h", ":Telescope help_tags<CR>", opt)
	map("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", opt)
	map("n", '""', ":Telescope registers<CR>", opt)
	map("n", "mm", ":Telescope marks<CR>", opt)
	map("n", "gd", ":Telescope lsp_definitions<CR>", opt)
	map("n", "gr", ":lua require('telescope.builtin').lsp_references({fname_width=40})<CR>", opt)

	vim.keymap.set("v", "<leader>f", function()
		local text = vim.getVisualSelection()
		require("telescope.builtin").live_grep({ default_text = text })
	end, opt)
end

M.dap = function()
	map("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", opt)
	map("n", "<leader>dn", ":lua require('dap').continue()<CR>", opt)
	map("n", "<leader>dt", ":lua require('dap').terminate()<CR>", opt)
	map("n", "<leader>di", ":lua require('dap').step_into()<CR>", opt)
	map("n", "<leader>ds", ":lua require('dap').step_over()<CR>", opt)
	map("n", "<leader>do", ":lua require('dap').step_out()<CR>", opt)
	map("n", "<leader>du", ":lua require('dapui').toggle()<CR>", opt)
end

M.mini = function()
	map("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { noremap = true, expr = true })
	map("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { noremap = true, expr = true })
end

M.svart = function()
	map("n", "s", ":noh<CR>:Svart<CR>", opt)
	map("n", "gs", ":noh<CR>:SvartRepeat<CR>", opt)
end

M.fterm = function()
	map("n", "<leader>,", ":lua require('FTerm').toggle()<CR>", opt)
	map("t", "<leader>,", "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>", opt)
end

return M
