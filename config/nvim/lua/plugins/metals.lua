local present, metals = pcall(require, 'metals')
if not present then return end

local metals_config = metals.bare_config
metals_config.init_options.statusBarProvider = "on"

vim.cmd [[augroup lsp]]
vim.cmd [[au!]]
vim.cmd [[au FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]]
vim.cmd [[augroup end]]
