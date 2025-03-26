vim.cmd('colorscheme xresources')

-- hide Cursor
vim.api.nvim_set_hl(0, 'Cursor', {
  blend = 100,
  fg = 'NONE',
  bg = '#FFFFFF',
})
vim.opt.guicursor:append("a:Cursor/lCursor")
