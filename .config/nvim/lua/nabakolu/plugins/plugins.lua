local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "nvim-tree/nvim-web-devicons",
    "seblj/nvim-tabline",
    "nvim-lualine/lualine.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "neovim/nvim-lspconfig",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "ptzz/lf.vim",
    "voldikss/vim-floaterm",
    "nvim-treesitter/nvim-treesitter",
    "https://github.com/chrisbra/Colorizer",
    "vimwiki/vimwiki",
    "romainl/vim-cool",
    "editorconfig/editorconfig-vim",
})

require('nabakolu.plugins.config.lf')
require('nabakolu.plugins.config.floaterm')
require('nabakolu.plugins.config.vimwiki')
require('nabakolu.plugins.config.lspconfig')
require('nabakolu.plugins.config.dap')
require('nabakolu.plugins.config.nvim-cmp')
require('nabakolu.plugins.config.treesitter')
require('nabakolu.plugins.config.lualine')
require('nabakolu.plugins.config.nvim-tabline')
require('nabakolu.plugins.config.colorizer')


