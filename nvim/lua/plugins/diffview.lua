return {
  'sindrets/diffview.nvim',
  config = function()
    require('diffview').setup()
    vim.keymap.set('n', '<leader>dv', ':DiffviewOpen<CR>')
    vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>')
  end,
}
