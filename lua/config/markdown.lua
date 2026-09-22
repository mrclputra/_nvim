require('livepreview.config').set({
  sync_scroll = true,
})

vim.keymap.set('n', '<leader>tp', '<cmd>LivePreview start<CR>', { desc = 'markdown preview' })
