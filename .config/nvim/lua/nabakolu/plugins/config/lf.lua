vim.g.lf_netrw = 1

vim.keymap.set('n', '<leader>f', '<cmd>Lf<CR>', { desc = "Open LF" })

require("lf").setup({
    escape_quit = false,
    winblend = 0,
    height = vim.fn.float2nr(vim.fn.round(0.8 * vim.o.lines)),  -- height of the *floating* window
    width = vim.fn.float2nr(vim.fn.round(0.8 * vim.o.columns)), -- width of the *floating* window


    -- This allows resetting the layout with <M-u>
    layout_mapping = "<M-u>",
    views = {
        { width = 0.800, height = 0.800 },
    }
})
