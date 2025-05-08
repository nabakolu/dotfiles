return {
  "rolv-apneseth/tfm.nvim",
  config = function()
    require('tfm').setup {
      file_manager = "lf",
      replace_netrw = true,
      enable_cmds = true,
      ui = {
        border = "single",
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.5,
      },
    }

    vim.keymap.set('n', '<leader>f', '<cmd>Tfm<CR>', { desc = "Open LF" })
    vim.keymap.set('n', '<leader>S', '<cmd>TfmSplit<CR>', { desc = "Open LF in Split" })
    vim.keymap.set('n', '<leader>V', '<cmd>TfmVsplit<CR>', { desc = "Open LF in VSplit" })
    vim.keymap.set('n', '<leader>T', '<cmd>TfmTabedit<CR>', { desc = "Open LF in Tab" })
  end,
}
