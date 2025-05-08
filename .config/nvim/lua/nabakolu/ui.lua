vim.cmd('colorscheme xresources')
vim.opt.termguicolors = true

vim.opt.guicursor =
'n-v-c-sm:block,i-ci-ve:hor50-blinkwait0-blinkoff25-blinkon25,r-cr-o:block-blinkwait0-blinkoff25-blinkon25'

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
vim.opt.tabstop = 2

-- vim.opt.shiftwidth to the same as tabsize
vim.opt.shiftwidth = 2

--always show tabline
vim.opt.showtabline = 2

-- show whitespace
vim.cmd('set list listchars=nbsp:¬,tab:»·,trail:·,extends:>')

-- single border on all floating windows
vim.o.winborder = "single"

-- make floating lsp windows be single bordered by default
local function make_floating_preview_opts(opts)
  local new_opts = opts or {}
  new_opts.border = new_opts.border or 'single'
  return new_opts
end

local orig_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = make_floating_preview_opts(opts)
  return orig_open_floating_preview(contents, syntax, opts, ...)
end

-- set lsp icons, underline, sort by severity and disable virtual text
vim.diagnostic.config {
  float = { border = "single" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
      [vim.diagnostic.severity.INFO] = ' ',
    }
  }
}


-- debug adapter icons
vim.fn.sign_define('DapBreakpoint', { text = '󰄯', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = '󰟃', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped' })
