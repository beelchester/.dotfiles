return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    -- Default options:
    require('gruvbox').setup {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = '', -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    }
    vim.cmd 'colorscheme gruvbox'
    vim.opt.termguicolors = true
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#89b4fa' })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#89b4fa' })
  end,
}
