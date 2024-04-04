return {
  'preservim/tagbar',
  config = function()
    vim.keymap.set('n', '<leader>a', '<cmd>TagbarToggle<cr>', { silent = true, desc = 'Tagbar' })
  end,
}
