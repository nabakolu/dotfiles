package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.hidden = true

vim.opt.updatetime = 500

vim.opt.timeout = false

vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

-- use mouse
vim.opt.mouse = "a"

-- make nvim fold by syntax
vim.opt.foldmethod = "manual"

-- start with every fold closed
vim.opt.foldenable = true
vim.opt.foldlevel = 999

-- make search not case sensitive
vim.opt.ignorecase = true

-- make search case sensitive if there are capital letters in the search text
vim.opt.smartcase = true

-- use two spaces instead of tab
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
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

vim.keymap.set('n', '<leader>v', ':vnew<CR>', { desc = "open new vsplit" })
vim.keymap.set('n', '<leader>s', ':new<CR>', { desc = "open new split" })
vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { desc = "open new tab" })

-- Ctrl-J and Ctr-K insert blank lines
vim.keymap.set('n', '<C-j>', 'o<ESC>', { desc = "insert blank line above" })
vim.keymap.set('n', '<C-k>', 'O<ESC>', { desc = "insert blank line below" })

-- make ´ jump to tag
vim.keymap.set('n', '´', '`')

-- cycle through buffers
vim.keymap.set('n', '<leader>bn', ':bn<CR>', { desc = "next buffer" })
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { desc = "previous buffer" })

vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "delete buffer" })

-- Check for changed file
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = { "*" },
  callback = function()
    local current_mode = vim.api.nvim_get_mode().mode
    if vim.fn.filereadable(vim.fn.expand("%:p")) == 1 and current_mode ~= 'i' then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight yanked text
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "highlight_yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- auto close pairs on end of line
vim.api.nvim_set_keymap("i", "{<CR>", "{\n}<Esc>O", { noremap = true, expr = false })
vim.api.nvim_set_keymap("i", "(<CR>", "(\n)<Esc>O", { noremap = true, expr = false })
vim.api.nvim_set_keymap("i", "[<CR>", "[\n]<Esc>O", { noremap = true, expr = false })
