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

local plugins = {

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('nabakolu.plugins.config.telescope') end
    },

    {
        'seblj/nvim-tabline',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('nabakolu.plugins.config.nvim-tabline') end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('nabakolu.plugins.config.lualine') end
    },

    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
        config = function() require('nabakolu.plugins.config.lspconfig') end
    },

    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
        config = function() require('nabakolu.plugins.config.dap') end
    },

    { "rcarriga/nvim-dap-ui",  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    { "stevearc/conform.nvim", config = function() require('nabakolu.plugins.config.conform') end },

    {
        'hrsh7th/nvim-cmp',
        dependencies = { { 'hrsh7th/cmp-vsnip', dependencies = { 'hrsh7th/vim-vsnip' } }, 'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline' },
        config = function() require('nabakolu.plugins.config.nvim-cmp') end
    },

    {
        "lmburns/lf.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
        config = function() require('nabakolu.plugins.config.lf') end
    },
    { "akinsho/toggleterm.nvim",               config = function() require('nabakolu.plugins.config.toggleterm') end },
    { 'nvim-treesitter/nvim-treesitter',       config = function() require('nabakolu.plugins.config.treesitter') end },
    { 'https://github.com/chrisbra/Colorizer', config = function() require('nabakolu.plugins.config.colorizer') end },

    {
        'vimwiki/vimwiki',
        config = function() require('nabakolu.plugins.config.vimwiki') end,
        init = function()
            vim.cmd [[
                let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': 'md'}]
                let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
                let g:vimwiki_global_ext = 0
                let g:vimwiki_markdown_link_ext = 1
                let g:vimwiki_automatic_nested_syntaxes = 1
            ]]
        end
    },

    { 'romainl/vim-cool' },
    { 'lewis6991/gitsigns.nvim', config = function() require('nabakolu.plugins.config.gitsigns') end },

    {
        'jbyuki/nabla.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function() require('nabakolu.plugins.config.nabla') end
    },

    { 'echasnovski/mini.clue', config = function() require('nabakolu.plugins.config.mini-clue') end },

    {
        'echasnovski/mini.comment',
        branch = 'stable',
        config = function() require('nabakolu.plugins.config.mini-comment') end
    },
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                config = function()
                    require("nvim-treesitter.configs").setup({
                        ensure_installed = { "markdown" },
                        highlight = { enable = true },
                    })
                end,
            },
        },
        opts = {
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            kitty_method = "normal",
        },
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        keys = {
            { '<leader>D', '<cmd>DBUIToggle<CR>', desc='toggle DBUI'}
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_notification_width = 20
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dbui",
                callback = function()
                    vim.api.nvim_buf_set_keymap(0, "n", "<C-j>", "<Plug>(DBUI_SelectLine)",
                        { noremap = false, silent = true })
                end,
            })
            -- automatically resize output to be half window height
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*",
                callback = function()
                    if vim.bo.filetype == "dbout" then
                        local win_height = vim.api.nvim_get_option("lines")
                        local half_height = math.floor(win_height * 0.5)
                        vim.cmd("resize " .. half_height)
                    end
                end,
            })
        end,
    }
}

require("lazy").setup(
    plugins,
    {
        ui = {
            border = "single",
        }
    }
)
