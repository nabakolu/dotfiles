vim.g.lf_map_keys = 0
vim.keymap.set('n', '<leader>ff', ':Lf<CR>', {desc="open file with lf"})
vim.keymap.set('n', '<leader>fc', ':Lfcd<CR>', {desc="switch working dir with lf"})
vim.keymap.set('n', '<leader>ft', ':LfNewTab<CR>', {desc="open file in new tab with lf"})
vim.keymap.set('n', '<leader>fv', ':vnew | :Lf<CR>', {desc="open file in vsplit with lf"})
vim.keymap.set('n', '<leader>fs', ':new | :Lf<CR>', {desc="open file in split with lf"})
vim.g.lf_replace_netrw = 1 -- Open lf when vim opens a directory
