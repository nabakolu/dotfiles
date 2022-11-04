" Plugin Settings
" ----------------

call plug#begin('~/.local/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'},
	Plug 'ptzz/lf.vim'
	Plug 'voldikss/vim-floaterm'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'},
	Plug 'https://github.com/chrisbra/Colorizer',
	Plug 'vimwiki/vimwiki',
	Plug 'romainl/vim-cool',
	Plug 'editorconfig/editorconfig-vim',
call plug#end()
