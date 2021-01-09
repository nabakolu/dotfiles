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

" use Ctrl-K to activate linting
nnoremap üt :ALEToggleBuffer<CR>

" use ün and üp to find next and previous errors
nmap <silent> üp <Plug>(ale_previous_wrap)
nmap <silent> ün <Plug>(ale_next_wrap)

" linting is disabled by default
autocmd BufEnter * ALEToggleBuffer
" ALE error and warnging signs
let g:ale_sign_error = 'EE'
let g:ale_sign_warning = '__'
