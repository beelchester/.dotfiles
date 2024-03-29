return {
  'tpope/vim-fugitive',
  opts = {},
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'fugitive' })
    vim.keymap.set('n', '<leader>cc', ':Git commit --signoff<CR>', { desc = 'commit with signoff' })
  end,
}
