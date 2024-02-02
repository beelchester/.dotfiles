require("sahil")
vim.cmd('autocmd VimEnter * NvimTreeToggle')
vim.api.nvim_exec([[
  augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]], false)
vim.g.rustfmt_autosave = 1

require'nvim-tree'.setup {}


require('telescope').setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", "dist", "package-lock.json", "package.json" },
  },
})

