return {
  'ggandor/leap.nvim',
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)', { desc = 'Leap forward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)', { desc = 'Leap backward' })
  end,
}
