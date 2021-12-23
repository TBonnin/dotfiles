local present, lspconfig = pcall(require, 'lspconfig')
if not (present) then return end

local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap = true, silent = true}

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.

    buf_set_keymap('n', 'T', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', 'D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>",
    --               opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
    --                opts)
    -- buf_set_keymap('n', '<space>wa',
    --                '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr',
    --                '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl',
    --                '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    --                opts)
    -- buf_set_keymap('n', '<space>e',
    --                '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
    --                opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
    --                opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
    --                opts)
    -- buf_set_keymap('n', '<space>q',
    --               '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    end
end

-------------
metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.on_attach = function(client, bufnr) 
    on_attach(client, bufnr)
    --require("metals").setup_dap() 
end
metals_config.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.cmd [[augroup lsp]]
vim.cmd [[au!]]
vim.cmd [[au FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]]
vim.cmd [[augroup end]]
-------------
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- 
-- lspconfig.metals.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     root_dir = vim.loop.cwd
-- }

-- replace the default lsp diagnostic symbols
function lspSymbol(name, icon)
    vim.fn.sign_define('LspDiagnosticsSign' .. name, {text = icon, numhl = 'LspDiagnosticsDefaul' .. name})
end

lspSymbol('Error', '')
lspSymbol('Warning', '')
lspSymbol('Information', '')
lspSymbol('Hint', '')

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {prefix = '', spacing = 0},
        signs = true,
        underline = true,
        -- set this to true if you want diagnostics to show in insert mode
        update_in_insert = false
    })

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
    if msg:match 'exit code' then return end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end
