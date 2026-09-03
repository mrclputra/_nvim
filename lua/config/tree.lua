vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
  view = { width = 30 },
  renderer = { group_empty = true },
  filters = { dotfiles = false },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = { enable = false },
    },
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.del('n', '<C-k>', { buffer = bufnr })
    vim.keymap.set('n', 'gi', api.node.show_info_popup, { desc = 'nvim-tree: Info', buffer = bufnr, nowait = true })
  end,
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'file explorer' })
