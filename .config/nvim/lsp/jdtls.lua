vim.lsp.config('jdtls', {
  root_dir = vim.fn.getcwd(), -- always use nvim cwd as root dir, must start nvim in correct folder
})
