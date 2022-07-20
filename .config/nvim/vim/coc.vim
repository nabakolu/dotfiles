nmap <silent> <Space>gd <Plug>(coc-definition)
nmap <silent> <Space>gy <Plug>(coc-type-definition)
nmap <silent> <Space>gi <Plug>(coc-implementation)
nmap <silent> <Space>gr <Plug>(coc-references)
nmap <silent> <Space>r :CocCommand document.renameCurrentWord<cr>
nnoremap <silent> <Space>K :call CocActionAsync('doHover')<cr>

" Remap keys for applying codeAction to the current buffer.
nmap <Space>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <Space>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

autocmd CursorHold * silent call CocActionAsync('highlight')
