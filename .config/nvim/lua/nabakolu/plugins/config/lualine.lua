require('lualine').setup {
    options = {
        component_separators = '',
        section_separators = '',
        globalstatus = true,
        theme = 'pywal',
    },
    sections = {
        lualine_b = {
            { 'b:gitsigns_head', icon = '' },
            {
                'diagnostics',

                -- Table of diagnostic sources, available sources are:
                --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                -- or a function that returns a table as such:
                --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                sources = { 'nvim_diagnostic' },

                -- Displays diagnostics for the defined severity types
                sections = { 'error', 'warn' },

                diagnostics_color = {
                    -- Same values as the general color option can be used here.
                    error = 'DiagnosticLualineError', -- Changes diagnostics' error color.
                    warn  = 'DiagnosticLualineWarn',  -- Changes diagnostics' warn color.
                },
                symbols = { error = " ", warn = " " },
                colored = true,           -- Displays diagnostics status in color if set to true.
                update_in_insert = false, -- Update diagnostics in insert mode.
                always_visible = true,    -- Show diagnostics even if there are none.
                cond = function ()
                    return vim.b.show_lsp_lualine == 1
                end
            }
        },
        lualine_c = {

            {

                'filename',

                path = 1,

            }

        },
        lualine_x = {
            {
                'filetype',
                colored = false,           -- Displays filetype icon in color if set to true
                icon_only = false,         -- Display only an icon for filetype
                icon = { align = 'left' }, -- Display filetype icon on the right hand side
                -- icon =    {'X', align='right'}
                -- Icon string ^ in table is ignored in filetype component
            }
        },
        lualine_y = {
            {
                'progress',
                color = 'Normal',
            }
        },
    }
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.b.show_lsp_lualine = 1
    end,
})
