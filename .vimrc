" Plugins here
call plug#begin()
" ale, for linting
Plug 'dense-analysis/ale'

call plug#end()

" sudo save with :W
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" use system clipboard
set clipboard=unnamedplus

" use mouse
set mouse=a

" show relative line number
set relativenumber

" move to correct tab when pressing enter
set autoindent

" activate syntax highlighting
syntax on

" show whitespace
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

nnoremap <C-K> :ALEToggleBuffer<CR>
