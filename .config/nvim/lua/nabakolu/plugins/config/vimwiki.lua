vim.keymap.set('n', '<leader>ww', '<cmd>VimwikiIndex<CR> :lcd %:p:h<CR>', {desc="open vimwiki"})
vim.keymap.set('n', '<leader>wv', '<cmd>vnew | :VimwikiIndex<CR>', {desc="open vimwiki in vsplit"})
vim.keymap.set('n', '<leader>ws', '<cmd>new | :VimwikiIndex<CR>', {desc="open vimwiki in split"})
vim.keymap.set('n', '<leader>wt', '<cmd>VimwikiTabIndex<CR>', {desc="open vimwiki in tab"})
