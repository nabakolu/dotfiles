vim.cmd('colorscheme xresources')
vim.opt.termguicolors = true

vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:hor50-blinkwait0-blinkoff25-blinkon25,r-cr-o:block-blinkwait0-blinkoff25-blinkon25'

-- make error and warnings be on the same line as line numbers
vim.opt.signcolumn = 'number'

-- show pressed keys
vim.opt.showcmd = true

-- dont show mode, as it is shown in the statusline
vim.opt.showmode = false

-- disable modelines due to ex:
vim.opt.modeline = false

-- enable line wrapping
vim.opt.wrap = true

-- activate syntax highlighting
vim.cmd('syntax on')

-- show relative line number
vim.opt.relativenumber = true

-- show current line number
vim.opt.number = true

-- vim.opt.tabsize to 4
vim.opt.tabstop = 4

-- vim.opt.shiftwidth to the same as tabsize
vim.opt.shiftwidth = 4

-- show whitespace
vim.cmd('set list listchars=nbsp:¬,tab:»·,trail:·,extends:>')



-- Tabline
vim.cmd [[

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
				let s .= '%#TabLineSelLastArrowColor# '
			else
				let s .= '%#TabLineLastArrowColor# '
			endif
		elseif i == tabpagenr() - 1
			let s .= '%#TabLineSelArrowColor# '
		elseif i == tabpagenr() - 2
			let s .= '%#TabLineBehindSelArrowColor# '
		else
			let s .= '|'
		endif
	endfor

	" after the last tab fill with TabLineFill and revim.opt.tab page nr
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
set statusline+=%#Normal#
set statusline+=%{'\ '}
set statusline+=%#PathColor#\ \ %{getcwd()}/
set statusline+=%#Normal#
set statusline+=%{'\ '}
set statusline+=%#FileColor#%f
set statusline+=%#Normal#\ 
set statusline+=%#ModeColor#%{&modified?'\[+\]':''}
set statusline+=%#ModeColor#%{&readonly?'\[\]':''}
set statusline+=%#Normal#
set statusline+=%=
set statusline+=%#FTColor#ft:\ %{&filetype!=#''?&filetype:'none'}
set statusline+=%#Normal#
set statusline+=%{'\ '}
set statusline+=%#PosColor#%2p%%\|%l:%-2v " Virtual column number


]]



