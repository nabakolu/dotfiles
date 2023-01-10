vim.keymap.set('n', '<Space>gd', '<Plug>(coc-definition)')
vim.keymap.set('n', '<Space>gy', '<Plug>(coc-type-definition)')
vim.keymap.set('n', '<Space>gi', '<Plug>(coc-implementation)')
vim.keymap.set('n', '<Space>gr', '<Plug>(coc-references)')
vim.keymap.set('n', '<Space>r', ':CocCommand document.renameCurrentWord<cr>')
vim.keymap.set('n', '<Space>K', ":call CocActionAsync('doHover')<cr>")

-- Remap keys for applying codeAction to the current buffer.
vim.keymap.set('n', '<Space>ac', '<Plug>(coc-codeaction)')

-- Apply AutoFix to problem on the current line.
vim.keymap.set('n', '<Space>qf', '<Plug>(coc-fix-current)')

vim.cmd [[
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

autocmd CursorHold * silent call CocActionAsync('highlight')
]]
