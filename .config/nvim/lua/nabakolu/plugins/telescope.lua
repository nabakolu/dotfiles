return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        color_devicons = false,
        mappings = {
          i = {
            ["<C-j>"] = "select_default",
            ["<C-q>"] = "close",
          },
          n = {
            ["d"] = "delete_buffer",
            ["<C-j>"] = "select_default",
            ["<C-q>"] = "close",
          }
        }
      },
    }
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>jj', builtin.find_files, {}, { desc = "telescope find file" })
    vim.keymap.set('n', '<leader>jg', builtin.live_grep, {}, { desc = "telescope live grep" })
    vim.keymap.set('n', '<leader>jb', builtin.buffers, {}, { desc = "telescope buffers" })
    vim.keymap.set('n', '<leader>jh', builtin.help_tags, {}, { desc = "telescope help tags" })
    vim.keymap.set('n', '<leader>jr', builtin.lsp_references, {}, { desc = "telescope lsp references" })
    vim.keymap.set('n', '<leader>jd', builtin.lsp_document_symbols, {}, { desc = "telescope lsp document symbols" })
  end
}
