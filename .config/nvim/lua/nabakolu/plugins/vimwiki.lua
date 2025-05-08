return {
  'vimwiki/vimwiki',
  config = function()
    vim.keymap.set('n', '<leader>ww', '<cmd>VimwikiIndex<CR> :lcd %:p:h<CR>', { desc = "open vimwiki" })
    vim.keymap.set('n', '<leader>wv', '<cmd>vnew | :VimwikiIndex<CR>', { desc = "open vimwiki in vsplit" })
    vim.keymap.set('n', '<leader>ws', '<cmd>new | :VimwikiIndex<CR>', { desc = "open vimwiki in split" })
    vim.keymap.set('n', '<leader>wt', '<cmd>VimwikiTabIndex<CR>', { desc = "open vimwiki in tab" })
  end,
  init = function()
    vim.g.vimwiki_list = {
      {
        path = '~/vimwiki/',
        syntax = 'markdown',
        ext = 'md'
      }
    }

    vim.g.vimwiki_ext2syntax = {
      ['.md'] = 'markdown',
      ['.markdown'] = 'markdown',
      ['.mdown'] = 'markdown'
    }

    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_markdown_link_ext = 1
    vim.g.vimwiki_automatic_nested_syntaxes = 1
  end
}
