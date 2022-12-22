local navic = require('nvim-navic')
navic.setup {}
local wk = require('which-key')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
wk.register({
  ['<space>'] = {
    name = '(lsp/telescope)',
    e = { vim.diagnostic.open_float, '(navic)open diagnostics on float' },
    q = { vim.diagnostic.setloclist, '(navic)open diagnostic location list' },
  },
  ['['] = {
    name = '(lsp/lspsaga)prev(',
    d = { vim.diagnostic.goto_prev, '(navic)go to prev diagnostic' },
  },
  [']'] = {
    name = '(lsp/lspsaga)next',
    d = { vim.diagnostic.goto_next, '(navic)go to next diagnostic' },
  },
})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  wk.register({
    g = {
      name = '(lsp/lspsaga/trouble/hlslens)goto/lspsaga',
      D = { vim.lsp.buf.declaration, '(lsp)go to declaration' },
      --d = { vim.lsp.buf.definition, 'go to difinition' },
      i = { vim.lsp.buf.implementation, '(lsp)go to implementation' },
      --r = { vim.lsp.buf.references, 'go to references' },
    },
    ['<C-k>'] = { vim.lsp.buf.signature_help, '(lsp)show signature help' },
    ['<space>'] = {
      w = {
        name = '(lsp)workspace',
        a = { vim.lsp.buf.add_workspace_folder, '(lsp)add workspace folder' },
        r = { vim.lsp.buf.remove_workspace_folder, '(lsp)remove workspace folder' },
        l = { function() print(vim.inspect(vim.lspconfig.buf.list_workspace_folders())) end, 'list workspace folder(lsp)' },
      },
      D = { vim.lsp.buf.type_definition, '(lsp)go to type definition' },
      ['rn'] = { vim.lsp.buf.rename, '(lsp)rename' },
      ['ca'] = { vim.lsp.buf.code_action, '(lsp)code action' },
      f = { function() vim.lsp.buf.format { async = true } end, '(lsp)format' },
    }
  }, bufopts)

  if client.server_capabilities.documentSymbolProvider then
    print("lsp and navic attached")
    navic.attach(client, bufnr)
  end
end

local lsp_flags = {
  -- this is the default in nvim 0.7+
  debounce_text_changes = 150,
}
require 'lspconfig'.pyright.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { "pyright-langserver", "--stdio", "--ignoreexternal"}
} --python
require 'lspconfig'.clangd.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --c/c++
require 'lspconfig'.jdtls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --java
require 'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --lua
require 'lspconfig'.ltex.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --latex
require 'lspconfig'.marksman.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --markdown
--require 'lspconfig'.sqlls.setup {
--  on_attach = on_attach,
--  flags = lsp_flags,
--} --sql
require 'lspconfig'.yamlls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --yaml
require 'lspconfig'.jsonls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --json
require 'lspconfig'.sqls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} -- sql(sqls)
require 'lspconfig'.lemminx.setup {
  on_attach = on_attach,
  flags = lsp_flags,
}
require 'lspconfig'.tsserver.setup {
  on_attach = on_attach,
  flags = lsp_flags,
}
require 'lspconfig'.quick_lint_js.setup {
  on_attach = on_attach,
  flags = lsp_flags
}

