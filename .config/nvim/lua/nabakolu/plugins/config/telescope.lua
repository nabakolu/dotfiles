require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-j>"] = "select_default",
                ["<C-q>"] = "close",
            },
            n = {
                ["d"] = "delete_buffer",
                ["<C-j>"] = "select_default",
                ["<C-q>"] = "close",
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>jj', builtin.find_files, {}, { desc = "telescope find file" })
vim.keymap.set('n', '<leader>jg', builtin.live_grep, {}, { desc = "telescope live grep" })
vim.keymap.set('n', '<leader>jb', builtin.buffers, {}, { desc = "telescope buffers" })
vim.keymap.set('n', '<leader>jh', builtin.help_tags, {}, { desc = "telescope help tags" })
vim.keymap.set('n', '<leader>jr', builtin.lsp_references, {}, { desc = "telescope lsp references" })
