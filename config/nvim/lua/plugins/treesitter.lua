require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  ignore_install = { "php", "swift", "phpdoc" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
