return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '/Users/sahil/Library/Mobile Documents/iCloud~md~obsidian/Documents/saaa',
      },
    },
    disable_frontmatter = true,
  },
}
