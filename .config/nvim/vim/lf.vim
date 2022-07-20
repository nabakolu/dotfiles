let g:lf_map_keys = 0
map <Space>ff :Lf<CR>
map <Space>fc :Lfcd<CR>
map <Space>ft :LfNewTab<CR>
map <Space>fv :vnew \| :Lf<CR>
map <Space>fs :new \| :Lf<CR>
let g:lf_replace_netrw = 1 " Open lf when vim opens a directory
