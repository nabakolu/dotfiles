" Plugins here
call plug#begin()
" ale, for linting
Plug 'dense-analysis/ale'
call plug#end()


" ----------------
" General Settings
" ----------------

"disabled " use system clipboard
"disabled set clipboard=unnamedplus

" use mouse
set mouse=a

" show relative line number
set relativenumber

" move to correct tab when pressing enter
set autoindent

" disable line wrapping
set nowrap

" activate syntax highlighting
syntax on

" set tabsize to 4
set tabstop=4

" show whitespace
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

" ALE error and warnging signs
let g:ale_sign_error = 'EE'
let g:ale_sign_warning = '__'

" linting is disabled by default
autocmd BufEnter * ALEDisableBuffer

" -----------
" Keybindings
" -----------

nnoremap <C-j> m`"="\n"<CR>p``j
nnoremap <C-k> m`"="\n"<CR>P``k

" use Ctrl-K to activate linting
nnoremap <silent> üt :ALEToggleBuffer<CR>

" use ün and üp to find next and previous errors
noremap <silent> üp <Plug>(ale_previous_wrap)
noremap <silent> ün <Plug>(ale_next_wrap)

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
