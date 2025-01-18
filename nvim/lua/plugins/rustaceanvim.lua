-- migrated from rust-tools since its archived now
-- https://github.com/LazyVim/LazyVim/pull/2198/files#top
-- old rust-tools config at the bottom
-- Tried to use this instead mainly because debugging wasn't working on rust-tools but its not working on rustaceanvim either
-- It's most likely due to some codelldb issue... but codelldb works fine on Bscode.
-- for debugging I will have to continue using Bscode :(
-- No Bscode... got it finally solved. There was arhitecture mismatch caused because I was running x86 version of neovim lol.
-- I deleted x86 brew itself... and reinstalled again with /opt/homebrew/bin/brew (arm)
-- All good now :)

local extensions_path = vim.env.HOME .. '/.vscode/extensions'
local codelldb_path = extensions_path .. '/vadimcn.vscode-lldb-1.10.0/adapter/codelldb'
local liblldb_path = extensions_path .. '/vadimcn.vscode-lldb-1.10.0/lldb/lib/liblldb.dylib'

return {
  'mrcjkb/rustaceanvim',
  -- version = '5.2.1',
  lazy = false,
  opts = {
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    },
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set('n', '<leader>ra', function()
          vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
          -- or vim.lsp.buf.codeAction() if you don't want grouping.
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
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        checkOnSave = {
          allFeatures = true,
          command = 'clippy',
          extraArgs = { '--no-deps' },
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
      }
    end

    vim.g.rustaceanvim = vim.tbl_deep_extend('force', vim.g.rustaceanvim(), opts or {})
  end,
}

-- config = function()
-- local bufnr = vim.api.nvim_get_current_buf()
-- vim.keymap.set('n', '<leader>k', function()
--   vim.cmd.RustLsp { 'hover', 'actions' }
-- end, { silent = true, buffer = bufnr })

-- local capabilities = require('lspconfig.configs').capabilities
--
-- local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
-- local codelldb_path = extension_path .. 'adapter/codelldb'
-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
--
-- local rt = require 'rust-tools'
-- local options = {
--   dap = {
--     adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
--   },
--   server = {
--     -- on_attach = on_attach,
--     on_attach = function(_, bufnr)
--       vim.keymap.set('n', '<leader>k', rt.hover_actions.hover_actions, { buffer = bufnr }, { describe = 'Rust hover action' })
--       -- vim.keymap.set('n', '<Leader>ra', rt.code_action_group.code_action_group, { buffer = bufnr }, { describe = 'Rust code action group' })
--     end,
--     capabilities = capabilities,
--     settings = {
--       ['rust-analyzer'] = {
--         cargo = {
--           features = 'all',
--           loadOutDirsFromCheck = true,
--           buildScripts = true,
--         },
--         -- Add clippy lints for Rust.
--         checkOnSave = {
--           features = 'all',
--           command = 'clippy',
--           extraArgs = { '--no-deps' },
--         },
--         procMacro = {
--           ignored = {
--             -- leptos_macro = {
--             --   'component',
--             --   'server',
--             -- },
--           },
--         },
--       },
--     },
--   },
--   tools = {
--     hover_actions = {
--       auto_focus = true,
--     },
--   },
-- }
-- rt.setup(options)
-- end,
