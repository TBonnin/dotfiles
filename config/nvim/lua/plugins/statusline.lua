local present, lualine = pcall(require, 'lualine')
if not present then
    print("lualine not found")
    return
end

local function lsp_clients()
    local clients = vim.lsp.get_active_clients()
    if #clients == 0 then
      return
    end
    local status = {}
    for _, client in pairs(clients) do
        table.insert(status, client.name)
    end
    return "LSP[" .. table.concat(status, " | ") .. "]"
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'palenight',
        section_separators = {'', ''},
        component_separators = {'', ''},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {
            {
                'diagnostics',
                sources = {"nvim_lsp"},
                symbols = {
                    error = ' ',
                    warn = ' ',
                    info = ' ',
                    hint = ' '
                }
            },
            'filetype'
        },
        lualine_y = {lsp_clients},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {'fugitive', 'nvim-tree', 'quickfix'}
}
