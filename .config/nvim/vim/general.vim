" General Settings
" ----------------

set nobackup
set nowritebackup
set hidden

set ut=500

set undodir=$HOME/.cache/nvim/undodir
set undofile

" use mouse
set mouse=a

" make nvim fold by syntax
set foldmethod=syntax
" start with every fold open
set nofoldenable
" show first line of every fold
set foldtext=FoldText()
set foldlevel=999

" make search not case sensitive
set ignorecase
" make search case sensitive if there are capital letters in the search text
set smartcase

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" move to correct tab when pressing enter
set autoindent
set copyindent
set preserveindent

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


" make h open help in new tab
cnoremap hh tab :h


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


" Function to set a nice fold text
function! FoldText()
    let l:lpadding = &fdc
    redir => l:signs
    execute 'silent sign place buffer='.bufnr('%')
    redir End
    let l:lpadding += l:signs =~ 'id=' ? 2 : 0

    if exists("+relativenumber")
      	if (&number)
        	let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
      	elseif (&relativenumber)
        	let l:lpadding += max([&numberwidth, strlen(v:foldstart - line('w0')), strlen(line('w$') - v:foldstart), strlen(v:foldstart)]) + 1
      	endif
    else
      	if (&number)
        	let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
      	endif
    endif

    " expand tabs
    let l:start = substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g')
    let l:end = substitute(substitute(getline(v:foldend), '\t', repeat(' ', &tabstop), 'g'), '^\s*', '', 'g')

    let l:info = ' (' . (v:foldend - v:foldstart) . ')'
    let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
    let l:width = winwidth(0) - l:lpadding - l:infolen

    let l:separator = ' … '
    let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
    let l:start = strpart(l:start , 0, l:width - strlen(substitute(l:end, '.', 'x', 'g')) - l:separatorlen)
    let l:text = l:start . ' … ' . l:end

    return l:text . repeat(' ', l:width - strlen(substitute(l:text, ".", "x", "g"))) . l:info
endfunction
