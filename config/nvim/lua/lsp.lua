-- disable default lsp keymaps
vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = function()
		pcall(vim.keymap.del, "n", "gra")
		pcall(vim.keymap.del, "n", "gri")
		pcall(vim.keymap.del, "n", "grn")
		pcall(vim.keymap.del, "n", "grr")
		pcall(vim.keymap.del, "n", "grt")
		pcall(vim.keymap.del, "n", "grx")
	end,
})

-- Global diagnostics config
local border = "single"
vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	update_in_insert = false,
	float = { border = border },
})

-- -- Floating borders for hover & signature help
local orig = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "single" -- your default
	return orig(contents, syntax, opts, ...)
end

-- Auto-show diagnostics in a float under cursor
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { scope = "cursor", border = "single", focusable = false })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		-- Mappings.
		local opts = { buffer = args.buf, silent = true }
		vim.keymap.set("n", "Y", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
		vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		vim.keymap.set(
			"n",
			"<leader>a",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "Code Action" })
		)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
	end,
})

-- ============================================================
--  SERVER CONFIGS
-- ============================================================

vim.lsp.config.terraformls = {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "terraform-vars", "hcl" },
	root_markers = { ".terraform", ".terraform.lock.hcl", ".git" },
}

vim.lsp.config.ts_ls = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
}

vim.lsp.config.lua_ls = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
}

vim.lsp.config.pyright = {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
}

vim.lsp.config.rust_analyzer = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
}

vim.lsp.config.gopls = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				parameterNames = true,
				functionTypeParameters = true,
				constantValues = true,
				rangeVariableTypes = true,
			},
		},
	},
}

vim.lsp.config.clangd = {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
}

vim.lsp.enable({
	"terraformls",
	"ts_ls",
	"lua_ls",
	"gopls",
	-- "pyright",
	-- "rust_analyzer",
	-- "clangd",
})
