require('mini.jump').setup({}) 

require('mini.pairs').setup({})

require('mini.completion').setup({}) 

require('mini.comment').setup({})

require('mini.tabline').setup({})

local indentscope = require('mini.indentscope')
indentscope.setup({ 
    draw = { 
        delay = 10,
        animation = indentscope.gen_animation('none'),
    },
})
