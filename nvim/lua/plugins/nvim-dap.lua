-- local dap, dapui = require 'dap', require 'dapui'

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    require('dapui').setup()

    require('dap').listeners.after.event_initialized['dapui_config'] = function()
      require('dapui').open()
    end

    require('dap').listeners.before.event_terminated['dapui_config'] = function()
      require('dapui').close()
    end

    require('dap').listeners.before.event_exited['dapui_config'] = function()
      require('dapui').close()
    end

    vim.keymap.set('n', '<Leader>db', ':DapToggleBreakpoint<CR>')
    vim.keymap.set('n', '<Leader>dc', ':DapContinue<CR>')
    vim.keymap.set('n', '<Leader>dx', ':DapTerminate<CR>')
    vim.keymap.set('n', '<Leader>do', ':DapStepOver<CR>')
    vim.keymap.set('n', '<Leader>di', ':DapStepInto<CR>')
    vim.keymap.set('n', '<Leader>dO', ':DapStepOut<CR>')
    vim.keymap.set('n', '<Leader>dr', ':DapRestart<CR>')
    -- Eval val under cursor
    vim.keymap.set('n', '<Leader>de', function()
      require('dapui').eval(nil, { enter = true })
    end, { desc = 'Dap evaluate value under cursor' })

    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#f38ba8' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#89b4fa' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#a6e3a1' })

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', numhl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', numhl = 'DapStopped' })
  end,
}
