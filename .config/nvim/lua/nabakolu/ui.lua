vim.cmd('colorscheme xresources')
vim.opt.termguicolors = true

vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:hor50-blinkwait0-blinkoff25-blinkon25,r-cr-o:block-blinkwait0-blinkoff25-blinkon25'

-- make error and warnings be on the same line as line numbers
vim.opt.signcolumn = 'yes'

-- show pressed keys
vim.opt.showcmd = true

-- dont show mode, as it is shown in the statusline
vim.opt.showmode = false

-- disable modelines due to ex:
vim.opt.modeline = false

-- enable line wrapping
vim.opt.wrap = true

-- activate syntax highlighting
vim.opt.syntax = 'on'

-- show relative line number
vim.opt.relativenumber = true

-- show current line number
vim.opt.number = true

-- vim.opt.tabsize to 4
vim.opt.tabstop = 4

-- vim.opt.shiftwidth to the same as tabsize
vim.opt.shiftwidth = 4

--always show tabline
vim.opt.showtabline = 2

-- show whitespace
vim.cmd('set list listchars=nbsp:¬,tab:»·,trail:·,extends:>')
