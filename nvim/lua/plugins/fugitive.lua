return {
  'tpope/vim-fugitive',
  opts = {},
  config = function()
    vim.keymap.set('n', '<leader>gs', function()
      vim.cmd 'Git'
      -- run in vsplit
      vim.cmd 'wincmd L'
    end, { desc = 'fugitive' })

    vim.keymap.set('n', '<leader>cc', ':Git commit --signoff<CR>', { desc = 'commit with signoff' })
  end,
}
