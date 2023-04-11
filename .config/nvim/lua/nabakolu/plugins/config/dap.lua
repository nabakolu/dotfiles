require("mason").setup()
require("mason-nvim-dap").setup({
    automatic_setup = true,
    handlers = {
        function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality
            require('mason-nvim-dap').default_setup(config)
        end,
    },
})

require("dapui").setup()

vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dt', function() require("dap").terminate() end)
vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end)

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint'})
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint'})
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint'})
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint'})
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped'})


local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
