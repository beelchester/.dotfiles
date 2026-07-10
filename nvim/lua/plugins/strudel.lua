return {
  'gruvw/strudel.nvim',
  build = 'npm ci',
  config = function()
    require('strudel').setup {
      ui = {
        hide_menu_panel = true,
        hide_top_bar = true,
        hide_error_display = true,
        -- Set `hide_code_editor = false` if you want to overlay the code editor
      },
    }
    local strudel = require 'strudel'

    vim.keymap.set('n', '<leader>sl', strudel.launch, { desc = 'Launch Strudel' })
    vim.keymap.set('n', '<leader>sq', strudel.quit, { desc = 'Quit Strudel' })
    vim.keymap.set('n', '<leader>sx', strudel.toggle, { desc = 'Strudel Toggle Play/Stop' })
    vim.keymap.set('n', '<leader>su', strudel.update, { desc = 'Strudel Update' })
  end,
}
