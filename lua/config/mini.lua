require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

require('mini.misc').setup()
require('mini.misc').setup_auto_root({
  '.git', '.hg', '.svn', 'Makefile',
  'package.json', 'Cargo.toml', 'go.mod', 'pyproject.toml',
})

require('mini.statusline').setup()
require('mini.notify').setup()
vim.notify = require('mini.notify').make_notify()

require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.ai').setup()
require('mini.indentscope').setup()

require('mini.diff').setup()
require('mini.git').setup()

local function strip_json_null(tbl)
  for k, v in pairs(tbl) do
    if v == vim.NIL then
      tbl[k] = nil
    elseif type(v) == 'table' then
      strip_json_null(v)
    end
  end
end

require('mini.completion').setup({
  lsp_completion = {
    process_items = function(items, base)
      for _, item in ipairs(items) do
        strip_json_null(item)
      end
      return MiniCompletion.default_process_items(items, base)
    end,
  },
})

require('mini.trailspace').setup()

require('mini.starter').setup()

local map = vim.keymap.set

map('n', '<leader>tw', function() require('mini.trailspace').trim() end, { desc = 'trim trailing whitespace' })

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'n', keys = '<C-r>' },
    { mode = 'i', keys = '<C-r>' },
  },
  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
    { mode = 'n', keys = '<Leader>c', desc = '+code' },
    { mode = 'n', keys = '<Leader>f', desc = '+find' },
    { mode = 'n', keys = '<Leader>t', desc = '+tools' },
    { mode = 'n', keys = '<Leader>w', desc = '+window' },
  },
  window = { delay = 300 },
})
