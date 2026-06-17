return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      enabled = function()
        local config = vim.fs.normalize(vim.fn.stdpath("config"))
        local file = vim.fs.normalize(vim.api.nvim_buf_get_name(0))

        return file:find(config, 1, true) == 1
      end,
    },
  },
}
