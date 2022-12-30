-- global vim settings
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.cindent = true
vim.o.number = true
vim.o.signcolumn = 'yes'
vim.g.mapleader = ','
vim.o.fileencodings = 'ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1'

-- packer.nvim
require('plugins')

require('config.mason')
require('config.lspconfig')
require('config.lspsaga')
require('config.lightbulb')
require('config.trouble')
require('config.coq')
require('config.treesitter')
require('config.tree')
require('config.lsp-colors')
require('config.telescope')
require('config.colorizer')
require('config.lualine')
require('config.barbar')
require('config.cursorline')
require('config.dashboard')
require('config.code-runner')
require('config.dap')
require('config.hlslens')
require('config.scrollview')
require('config.codewindow')
require('config.autotag')
require('config.treesitter-context')
require('config.web-devicons')
require('config.mini-ai')
require('config.indent-blankline')
require('config.autopairs')
require('config.competitest')
require('config.barbecue')
require('config.cinnamon')
require('config.nvim-surround')
require('config.textobj-diagnostic')
require('which-key')

require('colorscheme')
