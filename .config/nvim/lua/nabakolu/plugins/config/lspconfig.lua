require("mason").setup()
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
    end
}

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Displays hover information about the symbol under the cursor
        bufmap('n', '<space>K', '<cmd>lua vim.lsp.buf.hover()<cr>')

        -- Jump to the definition
        bufmap('n', '<space>gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

        -- Jump to declaration
        bufmap('n', '<space>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

        -- Lists all the implementations for the symbol under the cursor
        bufmap('n', '<space>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

        -- Jumps to the definition of the type symbol
        bufmap('n', '<space>go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

        -- Lists all the references
        bufmap('n', '<space>gr', '<cmd>lua vim.lsp.buf.references()<cr>')

        -- Renames all references to the symbol under the cursor
        bufmap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')

        -- Selects a code action available at the current cursor position
        bufmap('n', '<space>ac', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('x', '<space>ac', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

        -- Show diagnostics in a floating window
        bufmap('n', '<space>gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

        -- format code
        bufmap('n', '<space>F', '<cmd>lua vim.lsp.buf.format()<cr>')

    end
})



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
