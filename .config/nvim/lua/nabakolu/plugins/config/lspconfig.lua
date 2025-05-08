require("mason").setup({ ui = { border = "single" } })
require("mason-lspconfig").setup()

vim.lsp.config('lua_ls', {
    settings = {
        Lua = { diagnostics = { globals = { 'vim' }, }, }
    }
})

vim.lsp.config('ltex', {
    settings = {
        ltex = { language = "en-US" }
    }
})
require("nabakolu.plugins.config.ltex")

-- Displays hover information about the symbol under the cursor
vim.keymap.set('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = "display lsp hover information" })
--
-- Displays hover information about the symbol under the cursor
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<cr>',
    { desc = "display lsp diagnostic" })

-- Jump to the definition
vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "go to definition" })

-- Jump to declaration
vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = "go to declaration" })

-- Lists all the implementations for the symbol under the cursor
vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = "go to implementation" })

-- Jumps to the definition of the type symbol
vim.keymap.set('n', '<leader>go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {
    desc =
    "go to definition of type symbol"
})

-- Jumps to next error
vim.keymap.set('n', '<leader>ge', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR,})<cr>',
    { desc = "go to next error" })
vim.keymap.set('n', '<leader>gE', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR,})<cr>',
    { desc = "go to previous error" })

-- Jumps to next warning
vim.keymap.set('n', '<leader>gw', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN,})<cr>',
    { desc = "go to next warning" })
vim.keymap.set('n', '<leader>gW', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN,})<cr>',
    { desc = "go to previous warning" })

-- Jumps to next info
vim.keymap.set('n', '<leader>gq', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.INFO,})<cr>',
    { desc = "go to next info" })
vim.keymap.set('n', '<leader>gQ', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.INFO,})<cr>',
    { desc = "go to previous info" })

-- Lists all the references
vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = "list all references" })

-- Renames all references to the symbol under the cursor
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = "rename symbol" })

-- Selects a code action available at the current cursor position
vim.keymap.set('n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = "code action" })
vim.keymap.set('x', '<leader>ac', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', { desc = "code action in range" })

require('lspconfig.ui.windows').default_options = {
    border = "single"
}
