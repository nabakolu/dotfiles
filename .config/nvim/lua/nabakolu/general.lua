package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.hidden = true

vim.opt.updatetime = 500


vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true


-- use mouse
vim.opt.mouse = "a"

-- make nvim fold by syntax
vim.opt.foldmethod = "manual"
-- start with every fold closed
vim.opt.foldenable = true
-- show first line of every fold
-- vim.opt.foldtext=FoldText()
vim.opt.foldlevel = 999
-- Persistent Folds
-- local save_fold = vim.api.nvim_create_augroup("Persistent Folds", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*",
--   callback = function()
--     vim.cmd.mkview()
--   end,
--   group = save_fold,
-- })
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   pattern = "*",
--   callback = function()
--     vim.cmd.loadview({ mods = { emsg_silent = true } })
--   end,
--   group = save_fold,
-- })

-- make search not case sensitive
vim.opt.ignorecase = true
-- make search case sensitive if there are capital letters in the search text
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 
vim.opt.softtabstop = 4 
vim.opt.expandtab = true

-- move to correct tab when pressing enter
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.preserveindent = false

-- make splits appear on the right
vim.opt.splitright = true

-- make splits appear on the bottom
vim.opt.splitbelow = true


vim.g.mapleader = " "

vim.keymap.set('i', '<S-Tab>', '<C-V><Tab>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>v', ':vnew<CR>', {desc="open new vsplit"})
vim.keymap.set('n', '<leader>s', ':new<CR>', {desc="open new split"})
vim.keymap.set('n', '<leader>t', ':tabnew<CR>', {desc="open new tab"})

-- Ctrl-J and Ctr-K insert blank lines
vim.keymap.set('n', '<C-j>', 'o<ESC>', {desc="insert blank line above"})
vim.keymap.set('n', '<C-k>', 'O<ESC>', {desc="insert blank line below"})


-- make ´ jump to tag
vim.keymap.set('n', '´', '`')

-- cycle through buffers
vim.keymap.set('n', '<leader>bn', ':bn<CR>', {desc="next buffer"})
vim.keymap.set('n', '<leader>bp', ':bp<CR>', {desc="previous buffer"})

vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', {desc="delete buffer"})

-- make h open help in new tab
vim.keymap.set('c', 'hh', 'tab :h')

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = { "*" },
  callback = function()
    local current_mode = vim.api.nvim_get_mode().mode
    if vim.fn.filereadable(vim.fn.expand("%:p")) == 1 and current_mode ~= 'i' then
      vim.cmd("checktime")
    end
  end,
})

vim.cmd [[

" highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})
augroup END

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
]]
