vim.keymap.set('n', '<Space>ww', ':VimwikiIndex<CR> :lcd %:p:h<CR>')
vim.keymap.set('n', '<Space>wv', ':vnew | :VimwikiIndex<CR>')
vim.keymap.set('n', '<Space>ws', ':new | :VimwikiIndex<CR>')
vim.keymap.set('n', '<Space>wt', ':VimwikiTabIndex<CR>')


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
