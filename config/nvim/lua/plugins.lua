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
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato", -- latte, frappe, macchiato, mocha
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
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"folke/snacks.nvim",
		keys = require("mappings").snacks(),
		opts = {
			input = {},
			picker = {
				win = {
					input = {
						keys = {
							["<C-k>"] = { "list_up", mode = { "i", "n" } },
							["<C-j>"] = { "list_down", mode = { "i", "n" } },
							["<esc>"] = { "close", mode = { "i", "n" } },
							["<C-f>"] = { "toggle_grep", mode = { "i", "n" } },
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
			terminal = {
				win = {
					style = "float",
					border = "rounded",
					width = 0,
					height = 0.99,
					wo = {
						winblend = 5,
					},
				},
			},
		},
	},
	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.statusline")
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
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
		"linrongbin16/gitlinker.nvim",
		config = function()
			require("gitlinker").setup()

			local git_subcommands = {
				br = function()
					require("gitlinker").link({ action = require("gitlinker.actions").system })
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
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			require("mappings").neotree()
		end,
		config = function()
			require("neo-tree").setup({})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		dependencies = { "copilotlsp-nvim/copilot-lsp" }, -- (optional) for NES functionality
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				server_opts_overrides = {
					on_error = function() end,
				},
				filetypes = {
					["*"] = false,
					typescript = true,
					javascript = true,
					lua = true,
					html = true,
					go = true,
					python = true,
					rust = true,
					cpp = true,
					sh = true,
					terraform = true,
					yaml = true,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = false,
						dismiss = "<C-]>",
					},
				},
				panel = { enabled = false },
			})
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
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "djlint" },
			},
			format_after_save = {
				lsp_fallback = true,
			},
			formatters = {
				djlint = {
					args = { "--reformat", "-" },
				},
			},
		},
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
