vim.keymap.set('n', '<leader>ww', ':VimwikiIndex<CR> :lcd %:p:h<CR>', {desc="open vimwiki"})
vim.keymap.set('n', '<leader>wv', ':vnew | :VimwikiIndex<CR>', {desc="open vimwiki in vsplit"})
vim.keymap.set('n', '<leader>ws', ':new | :VimwikiIndex<CR>', {desc="open vimwiki in split"})
vim.keymap.set('n', '<leader>wt', ':VimwikiTabIndex<CR>', {desc="open vimwiki in tab"})


vim.cmd [[ 
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_global_ext = 1
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_automatic_nested_syntaxes = 1
]]
