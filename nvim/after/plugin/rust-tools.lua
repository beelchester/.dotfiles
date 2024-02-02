 -- local rt = require("rust-tools"), to make it global use 
 _G.rust_tools = require("rust-tools")

rust_tools.setup({
  server = {
    on_attach = function(_, bufnr)
          local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)


      -- Hover actions
      vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      -- vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
