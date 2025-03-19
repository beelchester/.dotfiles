local function apply_colors(groups)
  for group, attrs in pairs(groups) do
    local base = vim.api.nvim_get_hl(0, { name = group }) or {}
    vim.api.nvim_set_hl(0, group, vim.tbl_extend('force', base, attrs))
  end
end

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  --    opts = {
  -- integrations = {
  --     blink_cmp = true
  -- }
  --    },
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' }, -- Change the style of comments
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      default_integrations = true,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        treesitter_context = true,
        fzf = true,
        dap = true,
        dap_ui = true,
        gitgutter = true,
        harpoon = true,
        mason = true,
        markdown = true,
        alpha = true,
        neotree = true,
        which_key = true,
        telescope = true,
        diffview = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    }

    -- setup must be called before loading
    vim.cmd.colorscheme 'catppuccin-mocha'

    -- local mocha = require("catppuccin.palettes").get_palette "mocha"
    --                 apply_colors({
    --                     BlinkCmpLabel = { fg = mocha.overlay2 },
    --                     -- BlinkCmpLabelDeprecated = { fg = mocha.overlay0, style = { "strikethrough" } },
    --                     -- BlinkCmpLabelMatch = { fg = mocha.text, style = { "bold" } },
    --                     BlinkCmpKindText = { bg = mocha.green },
    --                     BlinkCmpKindMethod = { bg = mocha.blue },
    --                     BlinkCmpKindFunction = { bg = mocha.blue },
    --                     BlinkCmpKindConstructor = { bg = mocha.blue },
    --                     BlinkCmpKindField = { bg = mocha.green },
    --                     BlinkCmpKindVariable = { bg = mocha.flamingo },
    --                     BlinkCmpKindClass = { bg = mocha.yellow },
    --                     BlinkCmpKindInterface = { bg = mocha.yellow },
    --                     BlinkCmpKindModule = { bg = mocha.blue },
    --                     BlinkCmpKindProperty = { bg = mocha.blue },
    --                     BlinkCmpKindUnit = { bg = mocha.green },
    --                     BlinkCmpKindValue = { bg = mocha.peach },
    --                     BlinkCmpKindEnum = { bg = mocha.yellow },
    --                     BlinkCmpKindKeyword = { bg = mocha.mauve },
    --                     BlinkCmpKindSnippet = { bg = mocha.flamingo },
    --                     BlinkCmpKindColor = { bg = mocha.red },
    --                     BlinkCmpKindFile = { bg = mocha.blue },
    --                     BlinkCmpKindReference = { bg = mocha.red },
    --                     BlinkCmpKindFolder = { bg = mocha.blue },
    --                     BlinkCmpKindEnumMember = { bg = mocha.teal },
    --                     BlinkCmpKindConstant = { bg = mocha.peach },
    --                     BlinkCmpKindStruct = { bg = mocha.blue },
    --                     BlinkCmpKindEvent = { bg = mocha.blue },
    --                     BlinkCmpKindOperator = { bg = mocha.sky },
    --                     BlinkCmpKindTypeParameter = { bg = mocha.maroon },
    --                     BlinkCmpKindCopilot = { bg = mocha.teal },
    --                     BlinkCmpMenu = {},
    --                     BlinkCmpDocBorder = {link = "FloatBorder"},
    --                     BlinkCmpMenuBorder = {link = "FloatBorder"},
    --                     BlinkCmpSignatureHelpBorder = {link = "FloatBorder"},
    --                 })
  end,
}
