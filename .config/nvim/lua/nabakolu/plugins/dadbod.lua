return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod',                     lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    {                                                                                          -- optional saghen/blink.cmp completion source
      'saghen/blink.cmp',
      opts = {
        sources = {
          per_filetype = {
            sql = { 'lsp', 'dadbod', 'buffer', 'path' },
          },
          providers = {
            dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          },
        },
      },
    }
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  keys = {
    { '<leader>D', '<cmd>DBUIToggle<CR>', desc = 'toggle DBUI' }
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_notification_width = 20
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbui",
      callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<C-j>", "<Plug>(DBUI_SelectLine)",
          { noremap = false, silent = true })
      end,
    })
    -- automatically resize output to be half window height
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "dbout" then
          local win_height = vim.api.nvim_get_option("lines")
          local half_height = math.floor(win_height * 0.5)
          vim.cmd("resize " .. half_height)
        end
      end,
    })
  end,
}
