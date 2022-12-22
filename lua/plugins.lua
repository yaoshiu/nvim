-- boostrapping
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- auto compile
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'williamboman/mason.nvim'  -- mason
  use 'williamboman/mason-lspconfig.nvim' -- LSP Installer
  use 'nvim-lua/lsp-status.nvim' -- LSP Status
  use {
    'glepnir/lspsaga.nvim',
    branch = 'main',
  } -- lspsaga
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
  } -- lightbulb
  use {
    'andrewferrier/textobj-diagnostic.nvim',
  } -- diagnostic
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  } -- trouble
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    event = 'VimEnter',
    config = 'vim.cmd[[COQnow]]',
  }
  use {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts',
  }
  use {
    'ms-jpq/coq.thirdparty',
    branch = '3p',
  } -- coq
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  } -- treesitter
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'}}
  } -- telescope
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  } -- tree
  use 'folke/lsp-colors.nvim' -- lsp colors
  use 'NvChad/nvim-colorizer.lua' -- colorizer
  --use 'sunjon/shade.nvim' -- shade
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  } -- lualine
  use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'} -- barbar
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  } -- navic
  use {
    "utilyre/barbecue.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "smiteshp/nvim-navic",
      "kyazdani42/nvim-web-devicons", -- optional
    },
  } -- barbecue
  use'yamatsum/nvim-cursorline' -- cursorline
  use'glepnir/dashboard-nvim' -- dashboard
  use'nvim-telescope/telescope-file-browser.nvim'  --telescope-file-browser
  use'alex-laycalvert/telescope-dotfiles.nvim' -- telescope-dotfiles
  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' } -- code runner
  use'mfussenegger/nvim-dap' -- dap
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} } -- dap ui
  --use'Pocco81/dap-buddy.nvim' -- dap buddy
  use 'ofirgall/goto-breakpoints.nvim' -- goto breakpoints
  use {'Weissle/persistent-breakpoints.nvim'} -- persistent breakpoints
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  }) -- nvim surround
  use {'kevinhwang91/nvim-hlslens'} -- nvim hlslens
  use 'folke/which-key.nvim' -- which key
  use {
    'declancm/cinnamon.nvim',
  } -- cinnamon
  use 'dstein64/nvim-scrollview' -- scrollview
  use 'gorbit99/codewindow.nvim' -- codewindow
  use 'windwp/nvim-ts-autotag' -- autotag
  use 'nvim-treesitter/nvim-treesitter-context' -- treesitter context
  use "windwp/nvim-autopairs" -- autopairs
  use 'h-hg/fcitx.nvim' -- fcitx
  use 'p00f/nvim-ts-rainbow' -- ts rainbow
  use 'echasnovski/mini.ai' -- mini ai
  use 'jayp0521/mason-nvim-dap.nvim' -- mason nvim dap
  --use 'glepnir/indent-guides.nvim' -- indent guides
  use 'ThePrimeagen/vim-be-good' -- vim be good
  use 'lukas-reineke/indent-blankline.nvim' -- indent blankline
  use {
    'xeluxee/competitest.nvim', -- competitest
    requires = 'MunifTanjim/nui.nvim',
  }
  -- color schemes
  use 'marko-cerovac/material.nvim' -- material
  use 'rafamadriz/neon' -- neon

-- sync when first loaded
  if packer_bootstrap then
    require('packer').sync()
  end
end)
