return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup {
      open_mapping = [[<c-q>]],
      direction = 'float',
      float_opt = {
        winblend = 0,
      }
    }
  end
}
