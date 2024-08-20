--TODO: Find a way to disable icons
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    require('which-key').add {
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Document' },
      { '<leader>r', group = 'Rename' },
      { '<leader>s', group = 'Search' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>g', group = 'Git' },
      { '<leader>q', group = 'Persistence' },
    }
  end,
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
