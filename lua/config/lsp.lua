require('mason').setup()

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
    },
  },
})

require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'basedpyright', 'clangd' },
  automatic_enable = true,
})

vim.diagnostic.config({
  virtual_text = { current_line = true },
  severity_sort = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end

    map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
    map('n', 'grd', vim.lsp.buf.definition, 'Goto definition')
    map('n', 'grD', vim.lsp.buf.declaration, 'Goto declaration')
    map('n', 'gri', vim.lsp.buf.implementation, 'Goto implementation')
    map('n', 'grr', vim.lsp.buf.references, 'References')
    map('n', 'K', vim.lsp.buf.hover, 'Hover docs')
    map('n', '<leader>cr', vim.lsp.buf.rename, 'rename symbol')
    map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, 'code action')
    map('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, 'format buffer')

    map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Prev diagnostic')
    map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')
    map('n', '<leader>cd', vim.diagnostic.open_float, 'line diagnostics')
  end,
})
