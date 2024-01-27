local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	"nvim-lua/plenary.nvim",
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				compile = {
					enabled = false,
					path = vim.fn.stdpath("cache") .. "/catppuccin",
				},
				dim_inactive = {
					enabled = true,
					shade = "dark",
					percentage = 0.25,
				},
			})
			vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.telescope")
		end,
		init = function()
			require("mappings").telescope()
		end,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{
				"sudormrfbin/cheatsheet.nvim",
				event = "VimEnter",
				config = function()
					require("plugins.cheatsheet")
				end,
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("plugins.treesitter")
		end,
	},
	"nvim-treesitter/nvim-treesitter-context",
	{
		"hoob3rt/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.statusline")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		event = "BufReadPre",
		config = function()
			require("plugins.dap")
		end,
		init = function()
			require("mappings").dap()
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("plugins.lastplace")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"ray-x/lsp_signature.nvim",
		},
		config = function()
			require("plugins.signature")
			require("plugins.lspconfig")
		end,
	},
	{
		"onsails/lspkind-nvim",
		event = "BufEnter",
		config = function()
			require("lspkind").init()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		config = function()
			require("gitlinker").setup({ mappings = nil })
			vim.api.nvim_create_user_command("Gb", function()
				require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
			end, {})
			vim.api.nvim_create_user_command("Gbl", function()
				require("gitlinker").get_buf_range_url(
					"n",
					{ action_callback = require("gitlinker.actions").open_in_browser }
				)
			end, {})
		end,
	},
	{
		"tpope/vim-sleuth",
		event = "BufEnter",
	},
	{
		"echasnovski/mini.nvim",
		init = function()
			require("mappings").mini()
		end,
		config = function()
			require("plugins.mini")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		init = function()
			require("mappings").neotree()
		end,
		config = function()
			require("neo-tree").setup({})
		end,
	},
	{
		"declancm/cinnamon.nvim",
		enabled = false,
		config = function()
			require("cinnamon").setup({
				always_scroll = false,
				extra_keymaps = true,
				override_keymaps = true,
				max_length = 250,
				scroll_limit = 50,
				horizontal_scroll = false,
			})
			vim.keymap.set("n", "n", "<Cmd>lua Scroll('n')<CR>")
			vim.keymap.set("n", "N", "<Cmd>lua Scroll('N')<CR>")
		end,
	},
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = {
				["*"] = false,
				["typescript"] = true,
				["javascript"] = true,
				["lua"] = true,
				["html"] = true,
				["go"] = true,
				["python"] = true,
				["rust"] = true,
				["cpp"] = true,
				["sh"] = true,
			}
		end,
	},
	{
		"numToStr/FTerm.nvim",
		config = function()
			require("FTerm").setup({
				blend = 5,
				dimensions = {
					height = 1.0,
					width = 1.0,
				},
			})
		end,
		init = function()
			require("mappings").fterm()
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				search = {
					enabled = false,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
			},
		},
	},
	{
		"nvimdev/guard.nvim",
		dependencies = {
			"nvimdev/guard-collection",
		},
		config = function()
			local ft = require("guard.filetype")
			ft("lua"):fmt("stylua")
			ft("typescript,javascript,typescriptreact"):fmt("prettier")
			require("guard").setup({
				fmt_on_save = true,
				lsp_as_default_formatter = true,
			})
		end,
	},
}, {
	ui = {
		border = "rounded", -- accepts same border values as |nvim_open_win()|.
	},
})
