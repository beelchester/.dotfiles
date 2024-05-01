vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
-- vim.cmd 'autocmd VimEnter * :Neotree toggle'
vim.api.nvim_create_autocmd('TextChanged', {
  desc = 'Run :CordUpdate when the text in the buffer changes; it will restart presence if it was idle',
  pattern = '*',
  callback = function()
    vim.cmd 'CordUpdate'
  end,
})
vim.cmd 'autocmd VimEnter * :Alpha'
vim.keymap.set({ 'n', 'v', 'i', 'x' }, '<M-w>', '<C-w>')

vim.opt.conceallevel = 1
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>')
vim.keymap.set('n', '<leader>cn', '<Cmd>cnext<CR>')
vim.keymap.set('n', '<leader>cp', '<Cmd>cprev<CR>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>y', [["+Y]])
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Use `opts = {}` to force a plugin to be loaded.
  --  This is equivalent to:
  --    require('Comment').setup({})
  { 'numToStr/Comment.nvim', opts = {} },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false, keywords = {
      TODO = { color = 'info' },
      NOTE = { color = 'hint' },
    } },
  },

  {
    'wakatime/vim-wakatime',
    lazy = false,
    setup = function()
      vim.cmd [[packadd wakatime/vim-wakatime]]
    end,
  },

  { 'github/copilot.vim' },

  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },
  { 'mfussenegger/nvim-dap' },
  { 'tpope/vim-obsession' },
  {
    'akinsho/flutter-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'stevearc/dressing.nvim' },
    config = function()
      require('flutter-tools').setup {
        -- (uncomment below line for windows only)
        -- flutter_path = "home/flutter/bin/flutter.bat",

        debugger = {
          -- make these two params true to enable debug mode
          enabled = false,
          run_via_dap = false,
          register_configurations = function(_)
            require('dap').adapters.dart = {
              type = 'executable',
              command = vim.fn.stdpath 'data' .. '/mason/bin/dart-debug-adapter',
              args = { 'flutter' },
            }

            require('dap').configurations.dart = {
              {
                type = 'dart',
                request = 'launch',
                name = 'Launch flutter',
                dartSdkPath = 'home/flutter/bin/cache/dart-sdk/',
                flutterSdkPath = 'home/flutter',
                program = '${workspaceFolder}/lib/main.dart',
                cwd = '${workspaceFolder}',
              },
            }
            -- uncomment below line if you've launch.json file already in your vscode setup
            -- require("dap.ext.vscode").load_launchjs()
          end,
        },
        dev_log = {
          -- toggle it when you run without DAP
          enabled = false,
          open_cmd = 'tabedit',
        },
      }
    end,
  },
  -- for dart syntax hightling
  {
    'dart-lang/dart-vim-plugin',
  },
  {
    'mg979/vim-visual-multi',
  },

  { import = 'plugins' },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
