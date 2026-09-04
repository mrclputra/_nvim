local map = vim.keymap.set

require('smart-splits').setup({
  ignored_filetypes = { 'NvimTree' },
  default_amount = 4,
})
local smart_splits = require('smart-splits')

map('n', '<C-h>', smart_splits.move_cursor_left, { desc = 'Go to left window' })
map('n', '<C-j>', smart_splits.move_cursor_down, { desc = 'Go to lower window' })
map('n', '<C-k>', smart_splits.move_cursor_up, { desc = 'Go to upper window' })
map('n', '<C-l>', smart_splits.move_cursor_right, { desc = 'Go to right window' })

map('n', '<C-Up>', smart_splits.resize_up, { desc = 'Increase window height' })
map('n', '<C-Down>', smart_splits.resize_down, { desc = 'Decrease window height' })
map('n', '<C-Left>', smart_splits.resize_left, { desc = 'Decrease window width' })
map('n', '<C-Right>', smart_splits.resize_right, { desc = 'Increase window width' })

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
map('n', '<leader>wx', '<C-w>x', { desc = 'swap with next window' })
map('n', '<leader>wh', smart_splits.move_cursor_left, { desc = 'go to left window' })
map('n', '<leader>wj', smart_splits.move_cursor_down, { desc = 'go to lower window' })
map('n', '<leader>wk', smart_splits.move_cursor_up, { desc = 'go to upper window' })
map('n', '<leader>wl', smart_splits.move_cursor_right, { desc = 'go to right window' })

map('n', '<C-s>', '<cmd>write<CR>', { desc = 'Save file' })
map('i', '<C-s>', '<Esc><cmd>write<CR>', { desc = 'Save file and exit insert mode' })

-- Creates a toggleable terminal split. Tracks win+buf together (not just the
-- window id) so that switching the window to a different buffer, or closing
-- the window some other way (e.g. `:only`), doesn't leave the toggle in a
-- broken state on the next call. Also remembers the last size the window was
-- resized to (e.g. via smart-splits resize keymaps) and restores it the next
-- time the terminal is opened, for the rest of the nvim session.
local function make_terminal_toggle(split_cmd, default_size, get_size, set_size)
  local buf, win, last_size
  return function()
    local showing_term = win and vim.api.nvim_win_is_valid(win) and buf and vim.api.nvim_win_get_buf(win) == buf

    if showing_term then
      if #vim.api.nvim_list_wins() == 1 then
        return -- can't close the last window; leave it open
      end
      last_size = get_size(win)
      vim.api.nvim_win_close(win, false)
      win = nil
      return
    end

    -- not currently showing the terminal (never opened, or the window got
    -- repurposed for something else) -- always open a fresh split rather
    -- than hijacking whatever window used to hold the terminal
    vim.cmd(split_cmd)
    win = vim.api.nvim_get_current_win()
    set_size(win, last_size or default_size)

    if buf and vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_win_set_buf(win, buf)
    else
      vim.cmd('terminal')
      buf = vim.api.nvim_get_current_buf()
    end
    vim.cmd('startinsert')
  end
end

local toggle_terminal = make_terminal_toggle(
  'botright split',
  15,
  vim.api.nvim_win_get_height,
  vim.api.nvim_win_set_height
)

map('n', '<leader>tt', toggle_terminal, { desc = 'toggle terminal' })
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

local toggle_vterm = make_terminal_toggle(
  'botright vsplit',
  80,
  vim.api.nvim_win_get_width,
  vim.api.nvim_win_set_width
)

-- Terminals send Ctrl+/ and Ctrl+_ as the same byte, so bind both.
map({ 'n', 'i' }, '<C-/>', toggle_vterm, { desc = 'Toggle terminal (right)' })
map({ 'n', 'i' }, '<C-_>', toggle_vterm, { desc = 'Toggle terminal (right)' })
map('t', '<C-/>', toggle_vterm, { desc = 'Toggle terminal (right)' })
map('t', '<C-_>', toggle_vterm, { desc = 'Toggle terminal (right)' })
