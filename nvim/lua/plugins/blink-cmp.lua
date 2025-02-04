return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    { 'saghen/blink.compat', lazy = true, version = false },
    { 'rafamadriz/friendly-snippets' },
    { 'epwalsh/obsidian.nvim' },
  },

  -- use a release tag to download pre-built binaries
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = { preset = 'enter' },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },
    -- signature = {enabled = true};
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      -- menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end }
      list = {
        selection = {
          preselect = function(ctx)
            return ctx.mode ~= 'cmdline'
          end,
          auto_insert = function(ctx)
            return ctx.mode ~= 'cmdline'
          end,
        },
      },
      menu = {
        draw = {
          treesitter = { 'lsp' },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'obsidian', 'obsidian_new', 'obsidian_tags' },
      providers = {
        obsidian = {
          name = 'obsidian',
          module = 'blink.compat.source',
          score_offset = 100,
        },
        obsidian_new = {
          name = 'obsidian_new',
          module = 'blink.compat.source',
          score_offset = 100,
        },
        obsidian_tags = {
          name = 'obsidian_tags',
          module = 'blink.compat.source',
          score_offset = 100,
        },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
