vim.g.lf_map_keys = 0
vim.keymap.set('n', '<Space>ff', ':Lf<CR>')
vim.keymap.set('n', '<Space>fc', ':Lfcd<CR>')
vim.keymap.set('n', '<Space>ft', ':LfNewTab<CR>')
vim.keymap.set('n', '<Space>fv', ':vnew | :Lf<CR>')
vim.keymap.set('n', '<Space>fs', ':new | :Lf<CR>')
vim.g.lf_replace_netrw = 1 -- Open lf when vim opens a directory
