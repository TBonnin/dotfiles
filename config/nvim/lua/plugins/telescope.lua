local telescope = require('telescope')
telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
                ["<esc>"] = require("telescope.actions").close,
                ["<C-f>"] = require("telescope.actions").to_fuzzy_refine,
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
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
        }
    },
})
telescope.load_extension('fzf')
telescope.load_extension('ui-select')
