vim.g.lf_netrw = 1

vim.keymap.set('n', '<leader>f', ':Lf<CR>', { desc = "Open LF" })

require("lf").setup({
    escape_quit = false,
    winblend = 0,
})
