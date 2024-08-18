local on_attach = require('lspconfig.configs').on_attach
local capabilities = require('lspconfig.configs').capabilities
-- NOTE: upgrade macos to make lldb work
--
-- local codelldb_path = vim.fn.stdpath 'data' .. '/mason/bin/codelldb'
-- local extension_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/'
-- local codelldb_adapter_path = extension_path .. 'adapter/codelldb'
-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local options = {
  -- dap = {
  --   adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_adapter_path, liblldb_path),
  -- },
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          features = 'all',
          loadOutDirsFromCheck = true,
          buildScripts = true,
        },
        -- Add clippy lints for Rust.
        checkOnSave = {
          features = 'all',
          command = 'clippy',
          extraArgs = { '--no-deps' },
        },
        procMacro = {
          ignored = {
            -- leptos_macro = {
            --   'component',
            --   'server',
            -- },
          },
        },
      },
    },
  },
}

return {
  'simrat39/rust-tools.nvim',
  config = function()
    require('rust-tools').setup(options)
  end,
}
