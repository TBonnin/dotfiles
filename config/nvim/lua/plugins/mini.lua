require('mini.jump').setup()

require('mini.jump2d').setup({
    mappings = {
        start_jumping = '',
    },
})

require('mini.pairs').setup()

require('mini.completion').setup()

require('mini.comment').setup()

require('mini.tabline').setup()

local indentscope = require('mini.indentscope')
indentscope.setup({
    draw = {
        delay = 10,
        animation = indentscope.gen_animation('none'),
    },
})

vim.cmd [[ au Filetype neo-tree* lua vim.b.minicompletion_disable = true ]]
