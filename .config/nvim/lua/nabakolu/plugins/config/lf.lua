vim.g.lf_map_keys = 0
vim.keymap.set('n', '<leader>ff', ':Lf<CR>')
vim.keymap.set('n', '<leader>fc', ':Lfcd<CR>')
vim.keymap.set('n', '<leader>ft', ':LfNewTab<CR>')
vim.keymap.set('n', '<leader>fv', ':vnew | :Lf<CR>')
vim.keymap.set('n', '<leader>fs', ':new | :Lf<CR>')
vim.g.lf_replace_netrw = 1 -- Open lf when vim opens a directory
