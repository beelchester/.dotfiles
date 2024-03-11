local on_attach = require('lspconfig.configs').on_attach
local capabilities = require('lspconfig.configs').capabilities
local options = {
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
