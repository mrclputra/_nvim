require('diffview').setup()

local function toggle_diffview()
  if require('diffview.lib').get_current_view() then
    vim.cmd('DiffviewClose')
  else
    vim.cmd('DiffviewOpen')
  end
end

vim.keymap.set('n', '<leader>gd', toggle_diffview, { desc = 'toggle diffview' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = 'file history' })
