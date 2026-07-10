local extensions_path = vim.env.HOME .. '/.vscode-oss/extensions'
local codelldb_path = extensions_path .. '/vadimcn.vscode-lldb-1.11.5/adapter/codelldb'
local liblldb_path = extensions_path .. '/vadimcn.vscode-lldb-1.11.5/lldb/lib/liblldb.so'

return {
  'mrcjkb/rustaceanvim',
  lazy = false,
  opts = {
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    },

    server = {
      cmd = { 'lspmux', 'client' },

      flags = {
        debounce_text_changes = 500,
      },

      on_attach = function(_, bufnr)
        vim.keymap.set('n', '<leader>ra', function()
          vim.cmd.RustLsp 'codeAction'
        end, { silent = true, buffer = bufnr, desc = 'Rust code action' })

        vim.keymap.set('n', '<leader>rd', function()
          vim.cmd.RustLsp 'debuggables'
        end, { silent = true, buffer = bufnr, desc = 'Rust debuggables' })

        vim.keymap.set('n', '<leader>k', function()
          vim.cmd.RustLsp { 'hover', 'actions' }
        end, { silent = true, buffer = bufnr, desc = 'Rust hover action' })
      end,
    },

    settings = {
      ['rust-analyzer'] = {

        procMacro = {
          enable = false,
        },

        cargo = {
          allFeatures = false,
          loadOutDirsFromCheck = false,
          buildScripts = {
            enable = false,
          },
        },

        checkOnSave = false,

        files = {
          excludeDirs = { 'target', '.git', 'node_modules' },
        },

        inlayHints = {
          typeHints = { enable = false },
          parameterHints = { enable = false },
          chainingHints = { enable = false },
          closureReturnTypeHints = { enable = false },
          lifetimeElisionHints = { enable = false },
          bindingModeHints = { enable = false },
          reborrowHints = { enable = false },
        },
      },
    },
  },

  config = function(_, opts)
    vim.g.rustaceanvim = function()
      local cfg = require 'rustaceanvim.config'
      return {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        tools = opts.tools,
        server = opts.server,
        settings = opts.settings,
        ra_multiplex = opts.ra_multiplex,
      }
    end

    local base = vim.g.rustaceanvim()
    opts.dap = base.dap
    vim.g.rustaceanvim = opts
  end,
}

-- return {
--   'mrcjkb/rustaceanvim',
--   -- version = '5.2.1',
--   lazy = false,
--   opts = {
--     tools = {
--       hover_actions = {
--         auto_focus = true,
--       },
--     },
--     server = {
--       cmd = { 'lspmux', 'client' },
--       on_attach = function(_, bufnr)
--         vim.keymap.set('n', '<leader>ra', function()
--           vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
--           -- or vim.lsp.buf.codeAction() if you don't want grouping.
--         end, { silent = true, buffer = bufnr, desc = 'Rust code action' })
--         vim.keymap.set('n', '<leader>rd', function()
--           vim.cmd.RustLsp 'debuggables'
--         end, { silent = true, buffer = bufnr, desc = 'Rust debuggables' })
--         vim.keymap.set('n', '<leader>k', function()
--           vim.cmd.RustLsp { 'hover', 'actions' }
--         end, { silent = true, buffer = bufnr, desc = 'Rust hover action' })
--       end,
--     },
--     settings = {
--       ['rust-analyzer'] = {
--         cargo = {
--           allFeatures = true,
--           loadOutDirsFromCheck = false,
--           runBuildScripts = false,
--           workspace = true,
--           extraArgs = {
--             '--config',
--             '.cargo/config.local.toml',
--           },
--         },
--         checkOnSave = {
--           allFeatures = true,
--           -- command = 'clippy',
--           -- extraArgs = { '--no-deps' },
--           command = 'check',
--         },
--       },
--     },
--   },
--   config = function(_, opts)
--     vim.g.rustaceanvim = function()
--       local cfg = require 'rustaceanvim.config'
--       return {
--         dap = {
--           adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
--         },
--         tools = opts.tools,
--         server = opts.server,
--         settings = opts.settings,
--         ra_multiplex = opts.ra_multiplex,
--       }
--     end
--
--     local base = vim.g.rustaceanvim()
--     opts.dap = base.dap
--     vim.g.rustaceanvim = opts
--     -- vim.g.rustaceanvim = vim.tbl_deep_extend('force', vim.g.rustaceanvim(), opts or {})
--   end,
-- }
