local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local M = {}
local opt = {}

M.startup = function()
    map('i', 'jj', '<esc>', opt)

    -- Move up and down DISPLAYED line
    map('n', 'k', 'gk', opt)
    map('n', 'j', 'gj', opt)

    -- turn off highlighted results (nohlsearch) when pressing Enter.
    -- just pressing n or N will turn the highlight back again
    map('n', '<CR>', ':noh<CR>', opt)

    -- split line at cursor
    map('n', 'K', 'i<CR><esc>', opt)

    -- Kill the damned Ex mode.
    map('n', 'Q', '<nop>', opt)

    -- tabtab to leave terminal and go back to previous buffer
    map('t', '<TAB><TAB>', '<C-\\><C-n><C-^>', opt)

   -- open links
   map('n', 'gx', ':exec "!open <cWORD>"<cr><cr>', opt)

   -- remap C-g/C-t to Tab/S-Tab to iterate through results while searching
   map('c', '<Tab>', 'getcmdtype() =~ "[/?]" ? "<C-g>" : "<C-z>"', { expr = true, silent = false })
   map("c", '<S-Tab>', 'getcmdtype() =~ "[/?]" ? "<C-t>" : "<S-Tab>"', { expr = true, silent = false })

end

M.neotree = function() map('n', '<leader>n', ':Neotree reveal<CR>', opt) end

M.telescope = function()
    map('n', '<leader>r', ':Telescope resume<CR>', opt)
    map('n', '<leader>f', ':Telescope live_grep<CR>', opt)
    map('n', '<leader>s', ':Telescope grep_string<CR>', opt)
    map('n', '<leader>t', ':Telescope find_files <CR>', opt)
    map('n', '<leader>w', ':Telescope buffers<CR>', opt)
    map('n', '<leader>o', ':Telescope oldfiles<CR>', opt)
    map('n', '<leader>c', ':Telescope command_history<CR>', opt)
    map('n', '""', ':Telescope registers<CR>', opt)
    map('n', 'gd', ":Telescope lsp_definitions<CR>", opt)
    map('n', 'gr', ":Telescope lsp_references<CR>", opt)
    map('n', '<leader>a', ":lua require('telescope.builtin').lsp_code_actions({layout_config={width=0.6,height=0.6}})<CR>", opt)
    map('n', '<leader>d', ":Telescope lsp_workspace_diagnostics<CR>", opt)
end

M.hop = function()
    map('n', 's', ':HopChar1<CR>', opt)
    map('v', 's', ':HopChar1<CR>', opt)
end

M.mini = function()
    map('i', '<Tab>',   'pumvisible() ? "<C-n>" : "<Tab>"', { noremap = true, expr = true })
    map('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { noremap = true, expr = true })
end

return M
