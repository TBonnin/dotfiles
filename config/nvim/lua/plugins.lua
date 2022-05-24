local is_present, _ = pcall(require, 'packerInit')
local packer

if is_present then
    packer = require 'packer'
else
    return false
end

local use = packer.use

return packer.startup(function()

    use {
        'wbthomason/packer.nvim',
        event = 'VimEnter',
        config = function() require('plugins.packer') end
    }

    use {
        'drewtempelmeyer/palenight.vim',
        config = function() vim.cmd 'colorscheme palenight' end
    }

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

end)
