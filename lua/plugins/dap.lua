--- @module 'lazy'
--- @type LazySpec
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()
      require('nvim-dap-virtual-text').setup {}
      dap.adapters.lldb = {
        name = 'codelldb server',
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }

      vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<Leader>gb', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<Leader>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      if pcall(require, 'which-key') then
        require('which-key').add { '<Leader>d', group = '[D]ap', mode = 'n' }
      end
      vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = '[D]ap [C]ontinue' })
      vim.keymap.set('n', '<Leader>di', dap.step_into, { desc = '[D]ap Step [I]nto' })
      vim.keymap.set('n', '<Leader>do', dap.step_over, { desc = '[D]ap Step [O]ver' })
      vim.keymap.set('n', '<Leader>dx', dap.step_out, { desc = '[D]ap Step Out' })
      vim.keymap.set('n', '<Leader>db', dap.step_back, { desc = '[D]ap Step [B]ack' })
      vim.keymap.set('n', '<Leader>dr', dap.restart, { desc = '[D]ap [R]estart' })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
