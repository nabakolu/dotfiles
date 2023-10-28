local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

vim.cmd [[packadd packer.nvim]]

vim.cmd([[
augroup packer_auto_sync
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])


require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, config =
    "require('nabakolu.plugins.config.telescope')" }

    use { 'seblj/nvim-tabline', requires = { 'nvim-tree/nvim-web-devicons' }, config =
    "require('nabakolu.plugins.config.nvim-tabline')" }

    use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons' }, config =
    "require('nabakolu.plugins.config.lualine')" }

    use { 'williamboman/mason-lspconfig.nvim', requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' }, config =
    "require('nabakolu.plugins.config.lspconfig')" }

    use { 'jay-babu/mason-nvim-dap.nvim', requires = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' }, config =
    "require('nabakolu.plugins.config.dap')" }

    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    use({ "stevearc/conform.nvim", config = "require('nabakolu.plugins.config.conform')" })

    use { 'hrsh7th/nvim-cmp', requires = { { 'hrsh7th/cmp-vsnip', requires = { 'hrsh7th/vim-vsnip' } },
        'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline' }, config =
    "require('nabakolu.plugins.config.nvim-cmp')" }

    use { "lmburns/lf.nvim", requires = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" }, config =
    "require('nabakolu.plugins.config.lf')" }

    use { "akinsho/toggleterm.nvim", config = "require('nabakolu.plugins.config.toggleterm')" }

    use { 'nvim-treesitter/nvim-treesitter', config = "require('nabakolu.plugins.config.treesitter')" }

    use { 'https://github.com/chrisbra/Colorizer',
        config = "require('nabakolu.plugins.config.colorizer')"
    }

    use { 'vimwiki/vimwiki', config = "require('nabakolu.plugins.config.vimwiki')" }

    use { 'romainl/vim-cool' }

    use { 'lewis6991/gitsigns.nvim', config = "require('nabakolu.plugins.config.gitsigns')" }

    use { 'jbyuki/nabla.nvim', requires = { 'nvim-treesitter/nvim-treesitter' }, config =
    "require('nabakolu.plugins.config.nabla')" }

    --use { 'folke/which-key.nvim', config = "require('nabakolu.plugins.config.which-key')" }
    use { 'echasnovski/mini.clue', config = "require('nabakolu.plugins.config.mini-clue')" }

    use { 'echasnovski/mini.comment', branch = 'stable', config = "require('nabakolu.plugins.config.mini-comment')" }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
