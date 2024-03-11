return {
  'stevearc/aerial.nvim',
  config = function()
    require('aerial').setup()
    vim.keymap.set('n', '<leader>a', ':AerialToggle<CR>', { desc = 'aerial' })
  end,
}
