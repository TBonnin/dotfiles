require("mini.completion").setup({})

require("mini.comment").setup({})

require("mini.tabline").setup({})

require("mini.pairs").setup({})

local indentscope = require("mini.indentscope")
indentscope.setup({
	draw = {
		delay = 10,
		animation = indentscope.gen_animation.none(),
	},
})

vim.cmd([[ au Filetype neo-tree* lua vim.b.minicompletion_disable = true ]])
