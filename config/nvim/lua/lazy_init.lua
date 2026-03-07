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
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"folke/snacks.nvim",
		keys = require("mappings").snacks(),
		opts = {
			picker = {
				win = {
					input = {
						keys = {
							["<C-k>"] = { "list_up", mode = { "i", "n" } },
							["<C-j>"] = { "list_down", mode = { "i", "n" } },
							["<esc>"] = { "close", mode = { "i", "n" } },
						},
					},
				},
				layout = {
					fullscreen = true,
					preset = "vertical",
				},
				formatters = {
					file = {
						filename_first = false,
					},
				},
			},
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
			require("treesitter-context").setup()
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("plugins.lastplace")
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
		"ruifm/gitlinker.nvim",
		config = function()
			require("gitlinker").setup({ mappings = nil })

			local git_subcommands = {
				br = function()
					require("gitlinker").get_buf_range_url(
						"n",
						{ action_callback = require("gitlinker.actions").open_in_browser }
					)
				end,
			}

			vim.api.nvim_create_user_command("Git", function(opts)
				local fn = git_subcommands[opts.args]
				if fn then
					fn()
				else
					vim.notify("Unknown subcommand: " .. opts.args, vim.log.levels.WARN)
				end
			end, {
				nargs = "?",
				complete = function()
					return vim.tbl_keys(git_subcommands)
				end,
			})
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
				["terraform"] = true,
				["yaml"] = true,
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
			ft("go"):fmt("gofmt")
			ft("typescript,javascript,typescriptreact"):fmt("prettier")
			ft("html"):fmt({
				cmd = "prettier",
				args = {
					"--parser",
					"vue",
					"--print-width",
					"120",
					"--tab-width",
					"2",
					"--bracket-same-line",
					"true",
				},
				stdin = true,
			})
			vim.g.guard_config = {
				fmt_on_save = true,
				lsp_as_default_formatter = false,
			}
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({
				view = {
					merge_tool = {
						layout = "diff1_plain", -- see ':h diffview-config-view.x.layout'.
						disable_diagnostics = true,
					},
				},
			})
		end,
	},
}, {
	ui = {
		border = "rounded", -- accepts same border values as |nvim_open_win()|.
	},
})
