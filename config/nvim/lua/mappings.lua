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

end

M.bufferline = function()
    map('n', '<Tab>', ':BufferLineCycleNext<CR>', opt)
    map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', opt)
end

M.nvimtree = function() map('n', '<leader>n', ':NvimTreeFindFile<CR>', opt) end

M.telescope = function()
    map('n', '<leader>f', ':Telescope live_grep<CR>', opt)
    map('n', '<leader>t', ':Telescope find_files <CR>', opt)
    map('n', '<leader>w', ':Telescope buffers<CR>', opt)
    map('n', '<leader>r', ':Telescope oldfiles<CR>', opt)
    map('n', '<leader>h', ':Telescope command_history<CR>', opt)
    map('n', '<leader>gs', ':Telescope git_status<CR>', opt)
    map('n', '<leader>gl', ':Telescope git_commits<CR>', opt)
    map('n', '""', ':Telescope registers<CR>', opt)
    map('n', 'gh', ':Telescope help_tags<CR>', opt)
    map('n', 'gd', ":Telescope lsp_definitions<CR>", opt)
    map('n', 'gr', ":Telescope lsp_references<CR>", opt)
    map('n', '<leader>a', ":lua require('telescope.builtin').lsp_code_actions({layout_config={width=0.6,height=0.6}})<CR>", opt)
    map('n', '<leader>d', ":Telescope lsp_workspace_diagnostics<CR>", opt)
end

M.comment = function()
    map('n', '<leader>/', ':CommentToggle<CR>', opt)
    map('v', '<leader>/', ':CommentToggle<CR>', opt)
end

M.fugitive = function()
end

M.dap = function()
    map('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>", opt)
    map('n', '<leader>dr', ":lua require'dap'.continue()<CR>", opt)
    map('n', '<leader>di', ":lua require'dap'.step_into()<CR>", opt)
    map('n', '<leader>do', ":lua require'dap'.step_over()<CR>", opt)
end

return M
