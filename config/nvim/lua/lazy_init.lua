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

return require('lazy').setup({
    'nvim-lua/plenary.nvim',
    {
        'catppuccin/nvim',
        config = function()
            require('catppuccin').setup({
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
            vim.g.catppuccin_flavour = 'macchiato' -- latte, frappe, macchiato, mocha
            vim.cmd 'colorscheme catppuccin'
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugins.telescope') end,
        init = function() require('mappings').telescope() end,
        dependencies = {
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'sudormrfbin/cheatsheet.nvim',
                event = 'VimEnter',
                config = function() require('plugins.cheatsheet') end
            },
            'nvim-telescope/telescope-ui-select.nvim',
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        config = function() require('plugins.treesitter') end,
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
        'hoob3rt/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function() require('plugins.statusline') end
    },
    'frazrepo/vim-rainbow',
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'leoluz/nvim-dap-go',
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-telescope/telescope-dap.nvim',
        },
        event = 'BufReadPre',
        config = function() require('plugins.dap') end,
        init = function() require('mappings').dap() end,
    },
    {
        'ethanholz/nvim-lastplace',
        config = function() require('plugins.lastplace') end
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'jose-elias-alvarez/null-ls.nvim',
            'ray-x/lsp_signature.nvim',
        },
        config = function()
            require('plugins.signature')
            require('plugins.lspconfig')
        end,
    },
    {
        'onsails/lspkind-nvim',
        event = 'BufEnter',
        config = function() require('lspkind').init() end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    },
    {
        'ruifm/gitlinker.nvim',
        config = function()
            require('gitlinker').setup({ mappings = nil })
            vim.api.nvim_create_user_command(
                'Gb',
                function()
                    require('gitlinker').get_repo_url({ action_callback = require('gitlinker.actions').open_in_browser })
                end,
                {}
            )
            vim.api.nvim_create_user_command(
                'Gbl',
                function()
                    require('gitlinker').get_buf_range_url('n',
                        { action_callback = require('gitlinker.actions').open_in_browser })
                end,
                {}
            )
        end,
    },
    {
        'tpope/vim-sleuth',
        event = 'BufEnter',
    },
    {
        'echasnovski/mini.nvim',
        init = function() require('mappings').mini() end,
        config = function() require('plugins.mini') end,
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        init = function() require('mappings').neotree() end,
        config = function() require('neo-tree').setup({})
        end
    },
    {
        'declancm/cinnamon.nvim',
        config = function()
            require('cinnamon').setup({
                always_scroll = false,
                extra_keymaps = true,
                override_keymaps = true,
                max_length = 250,
                scroll_limit = 50,
                horizontal_scroll = false,
            })
            vim.keymap.set('n', 'n', "<Cmd>lua Scroll('n')<CR>")
            vim.keymap.set('n', 'N', "<Cmd>lua Scroll('N')<CR>")
        end
    },
    {
        'github/copilot.vim',
        config = function()
            vim.g.copilot_filetypes = {
                ['*'] = false,
                ['typescript'] = true,
                ['javascript'] = true,
                ['lua'] = true,
                ['html'] = true,
                ['go'] = true,
                ['python'] = true,
            }
        end,
    },
    {
        'numToStr/FTerm.nvim',
        config = function()
            require('FTerm').setup({
                blend = 5,
                dimensions = {
                    height = 1.0,
                    width = 1.0,
                },
            })
        end,
        init = function() require('mappings').fterm() end,
    },
    {
        'sindrets/diffview.nvim',
        config = function()
            require('FTerm').setup({
                view = {
                    merge_tool = {
                        layout = "diff3_mixed", -- see ':h diffview-config-view.x.layout'.
                        disable_diagnostics = true,
                    },
                },
            })
        end,
    },
    {
        'https://gitlab.com/madyanov/svart.nvim',
        init = function() require('mappings').svart() end,
    },
    'skywind3000/asyncrun.vim',
    {
        'gabrielpoca/replacer.nvim',
        config = function()
            vim.api.nvim_create_user_command(
                'Replacer',
                function()
                    require("replacer").run()
                end,
                {}
            )
        end,
    },
    {
        'windwp/nvim-autopairs',
        config = function() require("nvim-autopairs").setup() end,
    },
    {
        "Bryley/neoai.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        cmd = {
            "NeoAI",
            "NeoAIOpen",
            "NeoAIClose",
            "NeoAIToggle",
            "NeoAIContext",
            "NeoAIContextOpen",
            "NeoAIContextClose",
            "NeoAIInject",
            "NeoAIInjectCode",
            "NeoAIInjectContext",
            "NeoAIInjectContextCode",
        },
        keys = {
            { "<leader>as", desc = "summarize text" },
            { "<leader>ag", desc = "generate git message" },
        },
        config = function()
            require("neoai").setup({
                model = "gpt-4",
            })
        end,
    },
}, {
    ui = {
        border = "rounded", -- accepts same border values as |nvim_open_win()|.
    }
})
