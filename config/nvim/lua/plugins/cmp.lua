local present, cmp = pcall(require, "cmp")
if not present then return end

cmp.setup({
    sources = {
        { name = "buffer" },
        -- { name = "nvim_diagnostic" },
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
        ["<cr>"] = cmp.mapping.confirm({select = true}),
        ["<s-tab>"] = cmp.mapping.select_prev_item(),
        ["<tab>"] = cmp.mapping.select_next_item(),
    },
    formatting = {
        format = function(entry, item)
            item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
            })[entry.source.name]
            return item
        end,
    },
})
