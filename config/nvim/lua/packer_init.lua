-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim
-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost packer_init.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Install plugins
return packer.startup(function(use)

    -- Add you plugins here:
    use 'wbthomason/packer.nvim' -- packer can manage itself

    use({
        'catppuccin/nvim',
        as = 'catppuccin',
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
    })

    use {
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() require('plugins.statusline') end
    }

    use 'nvim-lua/plenary.nvim'

    use 'frazrepo/vim-rainbow'

    use {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugins.telescope') end,
        setup = function() require('mappings').telescope() end,
        requires = {
            'plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'sudormrfbin/cheatsheet.nvim',
                event = 'VimEnter',
                config = function() require('plugins.cheatsheet') end
            },
            'nvim-telescope/telescope-ui-select.nvim',
        }
    }

    use {
        'mfussenegger/nvim-dap',
        requires = {
            'leoluz/nvim-dap-go',
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-telescope/telescope-dap.nvim',
        },
        event = 'BufReadPre',
        config = function() require('plugins.dap') end,
        setup = function() require('mappings').dap() end,
    }


    use {
        'ethanholz/nvim-lastplace',
        config = function() require('plugins.lastplace') end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        'nvim-treesitter/nvim-treesitter-context',
        event = 'BufRead',
        config = function() require('plugins.treesitter') end
    }

    use {
        'neovim/nvim-lspconfig',
        requires = {
            'jose-elias-alvarez/null-ls.nvim',
            'ray-x/lsp_signature.nvim',
        },
        config = function()
            require('plugins.signature')
            require('plugins.lspconfig')
        end,
    }

    use {
        'onsails/lspkind-nvim',
        event = 'BufEnter',
        config = function() require('lspkind').init() end
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'plenary.nvim',
        config = function() require('gitsigns').setup() end
    }

    use {
        'tpope/vim-fugitive',
        requires = 'tpope/vim-rhubarb',
    }

    use {
        'tpope/vim-sleuth',
        event = 'BufEnter',
    }

    use {
        'echasnovski/mini.nvim',
        setup = function() require('mappings').mini() end,
        config = function() require('plugins.mini') end,
    }

    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = {
            'plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        setup = function() require('mappings').neotree() end,
        config = function()
            require('neo-tree').setup({
                close_if_last_window = true,
            })
        end
    }

    use {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = function()
            require 'hop'.setup({})
        end,
        setup = function() require('mappings').hop() end,
    }

    use {
        'declancm/cinnamon.nvim',
        config = function() require('cinnamon').setup({
                extra_keymaps = true,
                override_keymaps = true,
                max_length = 250,
                scroll_limit = 50,
                horizontal_scroll = false,
            })
        end
    }

    use {
        'github/copilot.vim',
        config = function()
            vim.g.copilot_filetypes = {
                ['*'] = false,
                ['typescript'] = true,
                ['javascript'] = true,
                ['lua'] = true,
                ['html'] = true,
                ['go'] = true,
            }
        end,
    }

    use {
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
        setup = function() require('mappings').fterm() end,
    }


    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
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
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
