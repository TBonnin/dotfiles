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

    use {
        'akinsho/bufferline.nvim',
        config = function() require('plugins.bufferline') end,
        setup = function() require('mappings').bufferline() end
    }

    use { 'hrsh7th/vim-vsnip' }
    use { 'hrsh7th/vim-vsnip-integ' }
    
    use {
        'hrsh7th/nvim-cmp',
        after = 'vim-vsnip',
        requires = {
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/vim-vsnip' },
            { 'hrsh7th/cmp-vsnip' },
        },
        config = function() require('plugins.cmp') end,
    }

    use {'nvim-lua/plenary.nvim', after = 'bufferline.nvim'}

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
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        setup = function() require('plugins.indent-blankline') end
    }

    use {
        'Pocco81/AutoSave.nvim',
        config = function() require('plugins.autosave') end,
        cond = function() return vim.g.auto_save == true end
    }

    use {
        'terrortylor/nvim-comment',
        config = function() require('nvim_comment').setup() end,
        setup = function() require('mappings').comment() end
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
        after = 'cmp-nvim-lsp',
        config = function() require('plugins.lspconfig') end
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

    use {
        'tpope/vim-fugitive',
        setup = function() require('mappings').fugitive() end
    }

    use {
        'tpope/vim-sleuth',
        event = 'BufEnter',
    }

    use {
        'mfussenegger/nvim-dap',
        after = 'plenary.nvim',
        setup = function() require('mappings').dap() end,
    }

    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }

    use {
        'scalameta/nvim-metals', 
        requires = { "nvim-lua/plenary.nvim" }
    }

    use {
        'echasnovski/mini.nvim',
        config = function() require('mini.jump').setup({}) end 
    }

    use {
        'phaazon/hop.nvim',
        branch = 'v1',
        config = function() require'hop'.setup() end,
        setup = function() require('mappings').hop() end,
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v1.x",
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
