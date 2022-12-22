require('mason').setup()
require('mason-lspconfig').setup({
  automatic_installation = true
})
require('mason-nvim-dap').setup({
  automatic_installation = true,
  automatic_setup = true,
})
