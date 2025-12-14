return {
  'theprimeagen/harpoon',
  config = function()
    require('harpoon').setup()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<leader>h', mark.add_file, { desc = 'Harpoon: Add File' })
    vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
    -- ui.nav_next()
    -- ui.nav_prev()

    vim.keymap.set('n', 'ga', function()
      ui.nav_file(1)
    end)
    vim.keymap.set('n', 'go', function()
      ui.nav_file(2)
    end)
    vim.keymap.set('n', 'ge', function()
      ui.nav_file(3)
    end)
    vim.keymap.set('n', 'gu', function()
      ui.nav_file(4)
    end)
    vim.keymap.set('n', 'gi', function()
      ui.nav_file(5)
    end)
    vim.keymap.set('n', 'gA', function()
      ui.nav_file(6)
    end)
    vim.keymap.set('n', 'gO', function()
      ui.nav_file(7)
    end)
    vim.keymap.set('n', 'gE', function()
      ui.nav_file(8)
    end)
    vim.keymap.set('n', 'gU', function()
      ui.nav_file(9)
    end)
    vim.keymap.set('n', 'gI', function()
      ui.nav_file(10)
    end)
  end,
}
