local present, ts_config = pcall(require, 'nvim-treesitter.configs')
if not present then return end

ts_config.setup {
  ensure_installed = "maintained",
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
