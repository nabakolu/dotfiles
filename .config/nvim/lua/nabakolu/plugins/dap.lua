return {
  'jay-babu/mason-nvim-dap.nvim',
  dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap', 'rcarriga/nvim-dap-ui', 'nvim-neotest/nvim-nio' },
  config = function()
    require('mason-nvim-dap').setup({
      automatic_setup = true,
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    })

    require('dapui').setup()

    vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'start/continue debug adapter' })
    vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end,
      { desc = 'toggle dap breakpoint' })
    vim.keymap.set('n', '<leader>dt', function() require('dap').terminate() end, { desc = 'terminate debug adapter' })
    vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, { desc = 'toggle dap ui' })

    local dap, dapui = require('dap'), require('dapui')
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
  end,
}
