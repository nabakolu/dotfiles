" General Settings
" ----------------

set nobackup
set nowritebackup
set hidden

" use mouse
set mouse=a

" make search not case sensitive
set ignorecase
" make search case sensitive if there are capital letters in the search text
set smartcase

" move to correct tab when pressing enter
set autoindent

" make splits appear on the right
set splitright

" make splits appear on the bottom
set splitbelow

" -----------
" Keybindings
" -----------

nmap <Space>v :vnew<CR>
nmap <Space>s :new<CR>
nmap <Space>t :tabnew<CR>

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