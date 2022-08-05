local present, telescope = pcall(require, "telescope")
if not present then return end

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
                ["<esc>"] = require("telescope.actions").close
            }
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
}

telescope.load_extension('fzf')
