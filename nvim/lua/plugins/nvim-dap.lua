-- local dap, dapui = require 'dap', require 'dapui'
--
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    -- dapui.setup()
    --
    --     dap.listeners.after.event_initialized['dapui_config'] = function()
    --       dapui.open()
    --     end
    --
    --     dap.listeners.before.event_terminated['dapui_config'] = function()
    --       dapui.close()
    --     end
    --
    --     dap.listeners.before.event_exited['dapui_config'] = function()
    --       dapui.close()
    --     end
    --
    --     vim.keymap.set('n', '<Leader>db', ':DapToggleBreakpoint<CR>')
    --     vim.keymap.set('n', '<Leader>dx', ':DapTerminate<CR>')
    --     vim.keymap.set('n', '<Leader>do', ':DapStepOver<CR>')
  end,
}
