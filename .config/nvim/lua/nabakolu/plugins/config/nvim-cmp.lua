vim.opt.completeopt = {'menu', 'menuone', 'noselect'}



local cmp = require('cmp')
cmp.setup {
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path', option = { trailing_slash = true } },
    },
    mapping = {
        ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ['<C-n>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),
        ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, {'i', 's'}),
    },
    window = {
        documentation = {
            border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'},
            scrollbar = '║',
            winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None', 
        },
        completion = {
            border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'},
            thin_scrollbar = '║',
            winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None', 
        }
    },
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
    capabilities = capabilities,
}
