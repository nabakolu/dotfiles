let plugins=0

if plugins==1
		" Plugins here
		call plug#begin()
		" ale, for linting
		Plug 'dense-analysis/ale'
		call plug#end()
endif


" ----------------
" General Settings
" ----------------

" set colourscheme
colorscheme desert

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

if plugins==1
		" ALE error and warnging signs
		let g:ale_sign_error = 'EE'
		let g:ale_sign_warning = '__'

		" linting is disabled by default
		"autocmd BufEnter * ALEDisableBuffer
		nmap <silent> üp <Plug>(ale_previous_wrap)
		nmap <silent> ün <Plug>(ale_next_wrap)

		highlight clear SignColumn

		" use Ctrl-K to activate linting
		nnoremap <silent> üt :ALEToggleBuffer<CR>
endif

" -----------
" Keybindings
" -----------

" use Y to use system clipboard
nnoremap Y "+

" Ctrl-J and Ctr-K insert blank lines
nnoremap <C-j> m`"="\n"<CR>p``j
nnoremap <C-k> m`"="\n"<CR>P``k



" --------
" Commands
" --------

" sudo save with :W
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!


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
