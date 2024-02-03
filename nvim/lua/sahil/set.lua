vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.opt.fillchars = { eob = " " }

vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

vim.g.blamer_show_in_visual_modes = 0
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_insert_modes = 0
