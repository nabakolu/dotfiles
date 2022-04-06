nmap <silent> <Space>gd <Plug>(coc-definition)
nmap <silent> <Space>gy <Plug>(coc-type-definition)
nmap <silent> <Space>gi <Plug>(coc-implementation)
nmap <silent> <Space>gr <Plug>(coc-references)
nmap <silent> <Space>r :CocCommand document.renameCurrentWord<cr>
nnoremap <silent> <Space>d :call CocActionAsync('doHover')<cr>
