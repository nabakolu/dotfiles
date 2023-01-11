local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/plugged')

Plug('neoclide/coc.nvim', {branch = 'release'})
Plug('ptzz/lf.vim')
Plug('voldikss/vim-floaterm')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('https://github.com/chrisbra/Colorizer')
Plug('vimwiki/vimwiki')
Plug('romainl/vim-cool')
Plug('editorconfig/editorconfig-vim')

vim.call('plug#end')

require('nabakolu.plugins.config.lf')
require('nabakolu.plugins.config.floaterm')
require('nabakolu.plugins.config.vimwiki')
require('nabakolu.plugins.config.coc')
require('nabakolu.plugins.config.treesitter')
