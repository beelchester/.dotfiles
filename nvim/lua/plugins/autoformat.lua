-- return {
--   -- Autoformat
--   'stevearc/conform.nvim',
--   opts = function()
--     -- Custom setup for Conform
--     require('conform').setup {
--       format_on_save = function(bufnr)
--         -- Disable with a global or buffer-local variable
--         if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
--           return
--         end
--         return { timeout_ms = 500, lsp_format = 'fallback' }
--       end,
--     }
--
--     -- Define user commands to enable/disable autoformatting
--     vim.api.nvim_create_user_command('FormatDisable', function(args)
--       if args.bang then
--         -- FormatDisable! disables formatting for this buffer only
--         vim.b.disable_autoformat = true
--       else
--         vim.g.disable_autoformat = true
--       end
--     end, {
--       desc = 'Disable autoformat-on-save',
--       bang = true,
--     })
--
--     vim.api.nvim_create_user_command('FormatEnable', function()
--       vim.b.disable_autoformat = false
--       vim.g.disable_autoformat = false
--     end, {
--       desc = 'Re-enable autoformat-on-save',
--     })
--
--     -- Return opts for the plugin
--     return {
--       notify_on_error = false,
--       formatters_by_ft = {
--         lua = { 'stylua' },
--         -- Add additional formatters as needed
--         -- python = { "isort", "black" },
--         javascript = { { "prettierd", "prettier" } },
--         typescript = { { "prettierd", "prettier" } },
--       },
--     }
--   end,
-- }

return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
  },
}
