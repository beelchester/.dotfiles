vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
-- vim.cmd 'autocmd VimEnter * :Neotree toggle'
vim.cmd 'autocmd VimEnter * :Alpha'
-- vim.keymap.set({ 'n', 'v', 'i', 'x' }, '<M-w>', '<C-,>') -- don't remember why I did this lol

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
-- tabstop, shiftwidth
-- :set ts=4 sw=4
-- changing only sw might be enough for manual change in tab width space

-- substitue word under cursor in whole file
vim.keymap.set('n', '<leader>sb', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Substitute word' })
vim.keymap.set('n', '<leader>sp', '<Cmd>vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>')
vim.keymap.set('n', '<leader>ct', '<Cmd>TSContextToggle<CR>')
vim.keymap.set('n', '<leader>cn', '<Cmd>cnext<CR>')
vim.keymap.set('n', '<leader>cp', '<Cmd>cprev<CR>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>y', [["+Y]])
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>qs', function()
  require('persistence').load()
end, { desc = 'Load session' })
vim.keymap.set('n', '<leader>qS', function()
  require('persistence').select()
end, { desc = 'Select session' })
vim.keymap.set('n', '<leader>ql', function()
  require('persistence').load { last = true }
end, { desc = 'Load last session' })
-- stop Persistence => session won't be saved on exit
vim.keymap.set('n', '<leader>qd', function()
  require('persistence').stop()
end, { desc = 'Stop Persistence' })

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
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {},
  },
  -- for dart syntax hightling
  {
    'dart-lang/dart-vim-plugin',
  },
  {
    'mg979/vim-visual-multi',
  },
  {
    'ThePrimeagen/vim-be-good',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
  -- lazy.nvim
  { import = 'plugins' },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
