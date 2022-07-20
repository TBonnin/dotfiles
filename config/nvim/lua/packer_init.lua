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
        "catppuccin/nvim",
	as = "catppuccin",
        config = function() 
            require('catppuccin').setup() 
            vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
            vim.cmd 'colorscheme catppuccin'
        end,
    })

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function() require('plugins.statusline') end
    }

    use { 'nvim-lua/plenary.nvim' }

    use {
        'nvim-telescope/telescope.nvim',
        after = 'plenary.nvim',
        config = function() require('plugins.telescope') end,
        setup = function() require('mappings').telescope() end,
        requires = {
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}, {
                'sudormrfbin/cheatsheet.nvim',
                event = 'VimEnter',
                after = 'telescope.nvim',
                config = function() require('plugins.cheatsheet') end
            }
        }
    }

    use {
        'Pocco81/AutoSave.nvim',
        config = function() require('plugins.autosave') end,
        cond = function() return vim.g.auto_save == true end
    }

    use {
        'ethanholz/nvim-lastplace',
        config = function() require('plugins.lastplace') end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        config = function() require('plugins.treesitter') end
    }

    use {
        'neovim/nvim-lspconfig',
        requires = { 'jose-elias-alvarez/null-ls.nvim' },
        config = function() require('plugins.lspconfig') end,
    }

    use {
        'onsails/lspkind-nvim',
        event = 'BufEnter',
        config = function() require('lspkind').init() end
    }

    use {
        'ray-x/lsp_signature.nvim',
        after = 'nvim-lspconfig',
        config = function() require('plugins.signature') end
    }

    use {
        'lewis6991/gitsigns.nvim',
        after = 'plenary.nvim',
        config = function() require('gitsigns').setup() end
    }

    use { 'tpope/vim-fugitive' }

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
        'phaazon/hop.nvim',
        branch = 'v1',
        config = function() require('hop').setup() end,
        setup = function() require('mappings').hop() end,
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        after = 'plenary.nvim',
        requires = { 
          "MunifTanjim/nui.nvim" 
        },
        setup = function() require('mappings').neotree() end,
        config = function ()
            require("neo-tree").setup({
                close_if_last_window = true,
            })
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
end)
