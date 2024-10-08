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

    vim.keymap.set('n', '<M-1>', function()
      ui.nav_file(1)
    end)
    vim.keymap.set('n', '<M-2>', function()
      ui.nav_file(2)
    end)
    vim.keymap.set('n', '<M-3>', function()
      ui.nav_file(3)
    end)
    vim.keymap.set('n', '<M-4>', function()
      ui.nav_file(4)
    end)
    vim.keymap.set('n', '<M-5>', function()
      ui.nav_file(5)
    end)
    vim.keymap.set('n', '<M-6>', function()
      ui.nav_file(6)
    end)
    vim.keymap.set('n', '<M-7>', function()
      ui.nav_file(7)
    end)
    vim.keymap.set('n', '<M-8>', function()
      ui.nav_file(8)
    end)
  end,
}
