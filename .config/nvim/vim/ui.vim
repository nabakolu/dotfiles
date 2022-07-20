colorscheme xresources
set termguicolors

set guicursor=n-v-c-sm:block,i-ci-ve:hor50-blinkwait0-blinkoff25-blinkon25,r-cr-o:block-blinkwait0-blinkoff25-blinkon25

" make error and warnings be on the same line as line numbers
set signcolumn=number

" show pressed keys
set showcmd

" dont show mode, as it is shown in the statusline
set noshowmode

" disable modelines due to ex:
set nomodeline

" enable line wrapping
set wrap

" activate syntax highlighting
syntax on

" show relative line number
set number relativenumber

" set tabsize to 4
set tabstop=4

" set shiftwidth to the same as tabsize
set shiftwidth=4

" show whitespace
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>


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

" statusline

let g:currentmode={
			\ 'n'  : 'NORMAL ',
			\ 'v'  : 'VISUAL' ,
			\ 'V'  : 'V-Line ',
			\ "\<C-V>" : 'V-BLOCK ',
			\ 'i'  : 'INSERT ',
			\ 'r'  : 'REPLACE',
			\ 'Rv' : 'V-REPL ',
			\ 'c'  : 'COMMAND',
			\ 't'  : 'TERM   ',
			\ '!'  : 'EXTERN ',
			\}


set laststatus=3
set statusline=
set statusline+=%#ModeColor#%{toupper(get(g:currentmode,mode(),'????????'))}
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





