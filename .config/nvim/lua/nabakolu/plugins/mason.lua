return {
  'mason-org/mason.nvim',
  config = function()
    require('mason').setup({ ui = { border = 'single' } })
  end,
}
