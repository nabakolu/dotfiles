call plug#begin('~/.vim/plugged')
	Plug 'scrooloose/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" General Settings
" ----------------

set nobackup
set nowritebackup
set hidden

" make error and warnings be on the same line as line numbers
set signcolumn=number

" make cursor 5 lines off top/bottom scroll
set scrolloff=5

" make split line not ugly
set fillchars+=vert:\ 

" set colourscheme
colorscheme delek

" show pressed keys
set showcmd

" use mouse
set mouse=a
set ttymouse=sgr

" make search not case sensitive
set ignorecase
" make search case sensitive if there are capital letters in the search text
set smartcase

" show relative line number
set relativenumber

" move to correct tab when pressing enter
set autoindent

" enable line wrapping
set wrap

" activate syntax highlighting
syntax on

" set tabsize to 4
set tabstop=4

" set shiftwidth to the same as tabsize
set shiftwidth=4

" show whitespace
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif


" change the default folder/directory glyph/icon
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''

" -----------
" Keybindings
" -----------

" use Y to use system clipboard
nnoremap Y "+

" Ctrl-J and Ctr-K insert blank lines
nnoremap <C-j> m`"="\n"<CR>p``j
nnoremap <C-k> m`"="\n"<CR>P``k

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Ctrl-F toggle NERDTree
nmap <C-f> :NERDTreeToggle<CR>

" --------
" Commands
" --------

" sudo save with :W
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" ------------
" auto close {
" ------------
function! s:CloseBracket()
		let line = getline('.')
		if line =~# '^\s*\(struct\|class\|enum\) '
				return "{\<Enter>};\<Esc>O"
		elseif searchpair('(', '', ')', 'bmn', '', line('.'))
				" Probably inside a function call. Close it off.
				return "{\<Enter>});\<Esc>O"
		else
				return "{\<Enter>}\<Esc>O"
		endif
endfunction
inoremap <expr> {<Enter> <SID>CloseBracket()
