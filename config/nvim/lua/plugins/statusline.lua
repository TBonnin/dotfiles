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
    local values = {}
    local keys = {}
    for _, client in pairs(clients) do
        if keys[client.name] == nil then
            table.insert(values, client.name)
            keys[client.name] = true
        end
    end
    return "LSP[" .. table.concat(values, " | ") .. "]"
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
                sources = {"nvim_diagnostic"},
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
        lualine_z = {'%l:%c(%p%%)'}
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
    extensions = {'fugitive', 'nvim-tree'}
}
