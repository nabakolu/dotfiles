require("mason").setup()
require("mason-null-ls").setup({
    handlers = {},
})

vim.keymap.set('n', '<leader><C-f>', '<cmd>lua vim.lsp.buf.format({ filter = function(client) return client.name == "null-ls" end, bufnr = bufnr, })<cr>', {desc="autoformat with null-ls"})
