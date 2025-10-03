local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local M = {}
local opt = {}

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

	-- open links
	map("n", "gx", ':exec "!open <cWORD>"<cr><cr>', { desc = "Open" })

	-- remap C-g/C-t to Tab/S-Tab to iterate through results while searching
	map("c", "<Tab>", 'getcmdtype() =~ "[/?]" ? "<C-g>" : "<C-z>"', { expr = true, silent = false })
	map("c", "<S-Tab>", 'getcmdtype() =~ "[/?]" ? "<C-t>" : "<S-Tab>"', { expr = true, silent = false })

	-- search on screen only
	map("n", "\\", "'/\\%(\\%>'.(line('w0')-1).'l\\%<'.(line('w$')+1).'l\\)\\&'", { expr = true, silent = true })
end

M.neotree = function()
	map("n", "<leader>1", ":Neotree reveal<CR>", { desc = "Show file in tree" })
end

M.snacks = function()
	return {
		{
			"<leader>r",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>w",
			function()
				Snacks.keys = {}
				Snacks.picker.smart({
					title = "Find Files",
					multi = { "buffers", "recent", "files" },
					format = "file", -- use `file` format for all sources
					matcher = {
						cwd_bonus = true, -- boost cwd matches
						frecency = true, -- use frecency boosting
						sort_empty = true, -- sort even when the filter is empty
					},
					transform = "unique_file",
				})
			end,
			desc = "Find Files",
		},
		{
			"<leader>b",
			function()
				Snacks.keys = {}
				Snacks.picker.buffers({
					sort_mru = true,
					ignore_current_buffer = true,
					transform = "unique_file",
				})
			end,
			desc = "Switch Buffer",
		},
		{
			"<leader>f",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Grep",
			mode = { "v" },
		},
		{
			"<leader>f",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
			mode = { "n", "i" },
		},
		{
			"<leader>e",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>h",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Tags",
		},
		{
			"<leader>s",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Document Symbols",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Definitions",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			'""',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"mm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>k",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>p",
			function()
				Snacks.picker.pickers()
			end,
			desc = "Pickers",
		},
	}
end

M.mini = function()
	map("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { noremap = true, expr = true })
	map("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { noremap = true, expr = true })
end

M.fterm = function()
	map("n", "<leader>,", ":lua require('FTerm').toggle()<CR>", { desc = "Toggle Terminal" })
	map("t", "<leader>,", "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>", opt)
end

return M
