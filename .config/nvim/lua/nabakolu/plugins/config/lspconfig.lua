require("mason").setup( { ui = { border = "single" } } )
require("mason-lspconfig").setup()

-- Add additional capabilities supported by nvim-cmp
local cap = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup { capabilities = cap }
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    ["pylsp"] = function()
        require("lspconfig").pylsp.setup { capabilities = cap,
            settings = { pylsp = { plugins = { jedi_completion = { include_params = true, }, }, }, }, }
    end,
    ["sumneko_lua"] = function()
        require'lspconfig'.sumneko_lua.setup { settings = { Lua = { diagnostics = { globals = {'vim'}, }, }, },
        }
    end,
}

-- Displays hover information about the symbol under the cursor
vim.keymap.set('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<cr>')

-- Jump to the definition
vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

-- Jump to declaration
vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

-- Lists all the implementations for the symbol under the cursor
vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

-- Jumps to the definition of the type symbol
vim.keymap.set('n', '<leader>go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

-- Jumps to next error
vim.keymap.set('n', '<leader>ge', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR,})<cr>')
vim.keymap.set('n', '<leader>gE', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR,})<cr>')

-- Jumps to next warning
vim.keymap.set('n', '<leader>gw', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN,})<cr>')
vim.keymap.set('n', '<leader>gW', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN,})<cr>')

-- Lists all the references
vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>')

-- Renames all references to the symbol under the cursor
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')

-- Selects a code action available at the current cursor position
vim.keymap.set('n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<cr>')
vim.keymap.set('x', '<leader>ac', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

-- Show diagnostics in a floating window
vim.keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- format code
vim.keymap.set('n', '<leader>F', '<cmd>lua vim.lsp.buf.format()<cr>')



vim.lsp.handlers["textDocument/hover"] =
vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = "single"
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
        border = "single"
    }
)

vim.diagnostic.config{
    float={border="single"},
    virtual_text=false,
}

require('lspconfig.ui.windows').default_options = {
    border = "single"
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
