map <Space>ww :VimwikiIndex<CR> :lcd %:p:h<CR>
map <Space>wv :vnew \| :VimwikiIndex<CR>
map <Space>ws :new \| :VimwikiIndex<CR>
map <Space>wt :VimwikiTabIndex<CR>


let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_global_ext = 0
