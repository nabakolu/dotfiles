" Plugin Settings
" ----------------

call plug#begin('~/.vim/plugged')
	Plug 'scrooloose/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" change the default folder/directory glyph/icon
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''

let g:NERDTreeQuitOnOpen = 1

" Ctrl-F toggle NERDTree
nmap <C-f> :NERDTreeToggle<CR>

" GoTo code navigation.
nmap <silent> <Space>gd <Plug>(coc-definition)
nmap <silent> <Space>gy <Plug>(coc-type-definition)
nmap <silent> <Space>gi <Plug>(coc-implementation)
nmap <silent> <Space>gr <Plug>(coc-references)
nmap <silent> <Space>ac <Plug>(coc-codeaction)
nnoremap <silent> <Space>d :call CocActionAsync('doHover')<cr>


" Tabline
" -----------------
set tabline=%!MyTabLine()

function MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSelColor#'
		else
			let s .= '%#TabLineColor#'
		endif

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'

		" the label is made by MyTabLabel()
		let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
		if i == tabpagenr('$') - 1
			if i == tabpagenr() - 1
				let s .= '%#TabLineSelLastArrowColor#'
			else
				let s .= '%#TabLineLastArrowColor#'
			endif
		elseif i == tabpagenr() - 1
			let s .= '%#TabLineSelArrowColor#'
		elseif i == tabpagenr() - 2
			let s .= '%#TabLineBehindSelArrowColor#'
		else
			let s .= ''
		endif
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= ''

	return s
endfunction

function MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let name = bufname(buflist[winnr - 1])
	if name == ''
		return '[No Name]'
	else
		return name
	endif
endfunction




" Statusline
" -----------------

let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL' ,
       \ 'V'  : 'V-Line ',
       \ "\<C-V>" : 'V-BLOCK ',
       \ 'i'  : 'INSERT ',
       \ 'r'  : 'REPLACE',
       \ 'Rv' : 'V-REPL ',
       \ 'c'  : 'COMMAND',
       \}


set laststatus=2
set statusline=
set statusline+=%#ModeColor#%{toupper(g:currentmode[mode()])}
set statusline+=%#ModeArrowColor#
set statusline+=%#PathColor#\ %{getcwd()}/
set statusline+=%#PathArrowColor#
set statusline+=%#FileColor#%f\ 
set statusline+=%#FileArrowColor#
set statusline+=%{&modified?'\ +\ ':''}
set statusline+=%{&readonly?'\ \ ':''}
set statusline+=%=
set statusline+=%#FTArrowColor#
set statusline+=%#FTColor#ft:\ %{&filetype!=#''?&filetype:'none'}
set statusline+=%#PosArrowColor#
set statusline+=%#PosColor#%2p%%%l:%-2v " Virtual column number


" General Settings
" ----------------

colorscheme nabakolu

set nobackup
set nowritebackup
set hidden

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
autocmd VimEnter * silent !echo -ne "\e[2 q"

" make error and warnings be on the same line as line numbers
set signcolumn=number

" make split line not ugly
set fillchars+=vert:\ 


" show pressed keys
set showcmd

" dont show mode, as it is shown in the statusline
set noshowmode

" use mouse
set mouse=a
" set ttymouse=sgr

" make search not case sensitive
set ignorecase
" make search case sensitive if there are capital letters in the search text
set smartcase

" show relative line number
set number relativenumber

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

" disable modelines due to ex:
set nomodeline

" make splits appear on the right
set splitright

" -----------
" Keybindings
" -----------


" Ctrl-J and Ctr-K insert blank lines
nnoremap <C-j> m`"="\n"<CR>p``j
nnoremap <C-k> m`"="\n"<CR>P``k

" make ´ jump to tag
noremap ´ `

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
