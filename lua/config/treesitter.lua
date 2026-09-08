local langs = {
  'lua', 'vim', 'vimdoc', 'query',           -- Neovim itself
  'python',
  'c', 'cpp',
  'bash', 'markdown', 'markdown_inline', 'json', 'yaml',
  'glsl',
}

require('nvim-treesitter').install(langs)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'vim', 'help', 'query', 'python', 'c', 'cpp', 'bash', 'sh', 'markdown', 'json', 'yaml', 'glsl' },
  callback = function()
    pcall(vim.treesitter.start)
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldenable = false
  end,
})
