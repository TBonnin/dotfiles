local telescope = require("telescope")
local builtin = require("telescope.builtin")

local pickers = {
	builtin.oldfiles,
	builtin.find_files,
	builtin.buffers,
	builtin.live_grep,
	builtin.lsp_document_symbols,
	index = 1,
}
pickers.cycle = function()
	if pickers.index >= #pickers then
		pickers.index = 1
	else
		pickers.index = pickers.index + 1
	end
	pickers[pickers.index]({ default_text = require("telescope.actions.state").get_current_line() })
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<esc>"] = require("telescope.actions").close,
				["<C-f>"] = require("telescope.actions").to_fuzzy_refine,
				["<C-p>"] = pickers.cycle,
			},
		},
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "top",
			width = 0.99,
			height = 0.99,
			vertical = {
				mirror = true,
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
		},
		file_ignore_patterns = { "vendor", "node_modules" },
		path_display = { "truncate" },
		set_env = { ["COLORTERM"] = "truecolor" },
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
