require('telescope').setup({
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
})
require('telescope').load_extension('ui-select')

local builtin = require('telescope.builtin')
local map = vim.keymap.set

map('n', '<leader><leader>', builtin.find_files, { desc = 'find files' })

map('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'find buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'help tags' })
map('n', '<leader>fr', builtin.oldfiles, { desc = 'recent files' })
map('n', '<leader>fd', builtin.diagnostics, { desc = 'diagnostics' })
map('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'document symbols (outline)' })

map('n', '<leader>cD', function() builtin.diagnostics({ bufnr = 0 }) end, { desc = 'buffer diagnostics' })
