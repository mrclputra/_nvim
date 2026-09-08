local telescope_builtin = require('telescope.builtin')

require('mason').setup()

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
    },
  },
})

vim.lsp.config('clangd', {
  cmd = { 'clangd', '--header-insertion=never' },
})

vim.lsp.config('html', {
  settings = {
    html = {
      format = {
        tabSize = 3,
        insertSpaces = true,
      },
    },
  },
})

require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'basedpyright', 'clangd', 'cmake', 'glsl_analyzer', 'jsonls', 'html' },
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
    map('n', 'gri', telescope_builtin.lsp_implementations, 'Goto implementation')
    map('n', 'grr', telescope_builtin.lsp_references, 'References')
    map('n', 'K', vim.lsp.buf.hover, 'Hover docs')

    map('n', '<leader>cgd', vim.lsp.buf.definition, 'goto definition')
    map('n', '<leader>cgD', vim.lsp.buf.declaration, 'goto declaration')
    map('n', '<leader>cgi', telescope_builtin.lsp_implementations, 'goto implementation')
    map('n', '<leader>cgr', telescope_builtin.lsp_references, 'references')
    map('n', '<leader>ck', vim.lsp.buf.hover, 'hover docs')

    map('n', '<leader>cr', vim.lsp.buf.rename, 'rename symbol')
    map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, 'code action')
    map('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, 'format buffer')

    map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Prev diagnostic')
    map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')
    map('n', '<leader>cd', vim.diagnostic.open_float, 'line diagnostics')
  end,
})
