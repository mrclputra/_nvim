local map = vim.keymap.set

map('n', 'H', '<C-w>h', { desc = 'Go to left window' })
map('n', 'J', '<C-w>j', { desc = 'Go to lower window' })
map('n', 'K', '<C-w>k', { desc = 'Go to upper window' })
map('n', 'L', '<C-w>l', { desc = 'Go to right window' })

map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('n', 'x', '"_x')
map('v', 'p', '"_dP')

map('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'split vertical' })
map('n', '<leader>ws', '<cmd>split<CR>', { desc = 'split horizontal' })
map('n', '<leader>wq', '<cmd>close<CR>', { desc = 'close window' })
map('n', '<leader>wo', '<cmd>only<CR>', { desc = 'close other windows' })
map('n', '<leader>w=', '<C-w>=', { desc = 'equalize window sizes' })
map('n', '<leader>ww', '<C-w>w', { desc = 'switch to next window' })
map('n', '<leader>wh', '<C-w>h', { desc = 'go to left window' })
map('n', '<leader>wj', '<C-w>j', { desc = 'go to lower window' })
map('n', '<leader>wk', '<C-w>k', { desc = 'go to upper window' })
map('n', '<leader>wl', '<C-w>l', { desc = 'go to right window' })

map('n', '<C-s>', '<cmd>write<CR>', { desc = 'Save file' })
map('i', '<C-s>', '<Esc><cmd>write<CR>', { desc = 'Save file and exit insert mode' })

local term_buf, term_win
local function toggle_terminal()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, false)
    term_win = nil
    return
  end

  vim.cmd('botright split')
  term_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_height(term_win, 15)

  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_win_set_buf(term_win, term_buf)
  else
    vim.cmd('terminal')
    term_buf = vim.api.nvim_get_current_buf()
  end
  vim.cmd('startinsert')
end

map('n', '<leader>tt', toggle_terminal, { desc = 'toggle terminal' })
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

local vterm_buf, vterm_win
local function toggle_vterm()
  if vterm_win and vim.api.nvim_win_is_valid(vterm_win) then
    vim.api.nvim_win_close(vterm_win, false)
    vterm_win = nil
    return
  end

  vim.cmd('botright vsplit')
  vterm_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(vterm_win, 80)

  if vterm_buf and vim.api.nvim_buf_is_valid(vterm_buf) then
    vim.api.nvim_win_set_buf(vterm_win, vterm_buf)
  else
    vim.cmd('terminal')
    vterm_buf = vim.api.nvim_get_current_buf()
  end
  vim.cmd('startinsert')
end

-- Terminals send Ctrl+/ and Ctrl+_ as the same byte, so bind both.
map({ 'n', 'i' }, '<C-/>', toggle_vterm, { desc = 'Toggle terminal (right)' })
map({ 'n', 'i' }, '<C-_>', toggle_vterm, { desc = 'Toggle terminal (right)' })
map('t', '<C-/>', toggle_vterm, { desc = 'Toggle terminal (right)' })
map('t', '<C-_>', toggle_vterm, { desc = 'Toggle terminal (right)' })
