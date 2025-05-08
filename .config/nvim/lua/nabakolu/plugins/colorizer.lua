return {
  'chrisbra/Colorizer',
  config = function()
    vim.keymap.set('n', '<leader>c', '<cmd>ColorToggle<CR>', { desc = "toggle css color highlight" })
  end,
}
