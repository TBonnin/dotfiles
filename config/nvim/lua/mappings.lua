local function map(mode, lhs, rhs, opts)
	local options = { silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

local M = {}

M.startup = function()
	map("i", "jj", "<esc>")

	-- Move up and down DISPLAYED line
	map("n", "k", "gk")
	map("n", "j", "gj")

	-- turn off highlighted results (nohlsearch) when pressing Enter.
	-- just pressing n or N will turn the highlight back again
	-- in quickfix window, pressing Enter will jump to the error, so undefine the mapping there
	map("n", "<CR>", ":noh<CR>")
	vim.api.nvim_create_autocmd("FileType", { pattern = "qf", command = [[nnoremap <buffer> <CR> <CR>]] })

	-- split line at cursor
	map("n", "K", "i<CR><esc>")

	-- Kill the Ex mode and command history
	map("n", "Q", "<nop>")
	map("n", "q:", "<nop>")

	-- open links
	map("n", "gx", ':exec "!open <cWORD>"<cr><cr>', { desc = "Open" })

	-- -- remap C-g/C-t to Tab/S-Tab to iterate through results while searching
	map("c", "<Tab>", function()
		local type = vim.fn.getcmdtype()
		if type == "/" or type == "?" then
			return vim.api.nvim_replace_termcodes("<C-g>", true, true, true)
		end
		return vim.api.nvim_replace_termcodes("<C-z>", true, true, true)
	end, { expr = true, silent = false })

	map("c", "<S-Tab>", function()
		local type = vim.fn.getcmdtype()
		if type == "/" or type == "?" then
			return vim.api.nvim_replace_termcodes("<C-t>", true, true, true)
		end
		return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
	end, { expr = true, silent = false })

	-- search on screen only
	map("n", "\\", "'/\\%(\\%>'.(line('w0')-1).'l\\%<'.(line('w$')+1).'l\\)\\&'", { expr = true, silent = true })
end

M.neotree = function()
	map("n", "<leader>1", ":Neotree reveal<CR>", { desc = "Show file in tree" })
end

M.snacks = function()
	return {
		{
			"<leader>,",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "Terminal",
			mode = { "n", "t" },
		},
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
					multi = { "buffers", "recent", "git_files", "files" },
					format = "file", -- use `file` format for all sources
					transform = (function()
						local current_buf = vim.api.nvim_get_current_buf()
						return function(item, ctx)
							if
								require("snacks.picker.transform").unique_file(item, ctx) == false
								or item.buf == current_buf
							then
								return false
							end
							item.buf_lastused = item.info and item.info.lastused or 0
						end
					end)(),

					sort = { fields = { "buf_lastused:desc", "score:desc", "#text", "idx" } },
					matcher = {
						fuzzy = true, -- use fuzzy matching
						sort_empty = true, -- sort even when the filter is empty
						ignorecase = true, -- use ignorecase
						smartcase = false, -- use smartcase
						filename_bonus = true, -- boost filename matches
						cwd_bonus = true, -- boost cwd matches
						history_bonus = true, -- boost matches from history
						frecency = true, -- use frecency boosting
					},
					formatters = {
						file = {
							filename_first = false,
							truncate = 80,
						},
					},
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
	map("i", "<Tab>", function()
		if vim.fn.pumvisible() == 1 then
			return vim.api.nvim_replace_termcodes("<C-n>", true, true, true)
		end
		local ok, suggestion = pcall(require, "copilot.suggestion")
		if ok and suggestion.is_visible() then
			suggestion.accept()
			return ""
		end
		return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
	end, { expr = true })

	map("i", "<S-Tab>", function()
		if vim.fn.pumvisible() == 1 then
			return vim.api.nvim_replace_termcodes("<C-p>", true, true, true)
		end
		return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
	end, { expr = true })
end

return M
