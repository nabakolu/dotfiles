" Plugin Settings
" ----------------

call plug#begin('~/.local/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'},
	Plug 'easymotion/vim-easymotion',
	Plug 'ptzz/lf.vim'
	Plug 'voldikss/vim-floaterm'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'},
	Plug 'https://github.com/chrisbra/Colorizer',
call plug#end()
