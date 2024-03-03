require("sahil")
vim.cmd('autocmd VimEnter * NvimTreeToggle')
vim.api.nvim_exec([[
  augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]], false)
vim.g.rustfmt_autosave = 1
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.g.copilot_filetypes = {markdown = true, yaml = true}

require'nvim-tree'.setup {}


require('telescope').setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", "dist", "package-lock.json", "package.json" },
  },
})

