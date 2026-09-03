vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.cursorline = true
opt.wrap = false

opt.expandtab = true
opt.shiftwidth = 3
opt.tabstop = 3
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8

opt.undofile = true
opt.swapfile = false
opt.clipboard = 'unnamedplus'
opt.mouse = 'a'

opt.updatetime = 250
opt.timeoutlen = 300

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.completeopt = 'menuone,noselect,fuzzy'

vim.env.RIPGREP_CONFIG_PATH = vim.fn.stdpath('config') .. '/.ripgreprc'
