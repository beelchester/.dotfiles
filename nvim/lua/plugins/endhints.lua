return {
  'chrisgrieser/nvim-lsp-endhints',
  event = 'LspAttach',

  config = function()
    vim.lsp.inlay_hint.enable(false)
  end,
  opts = {
    autoEnableHints = false, -- not working
  },
}
