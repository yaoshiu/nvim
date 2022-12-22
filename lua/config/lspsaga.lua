local saga = require('lspsaga')
local wk = require('which-key')

saga.init_lsp_saga()

wk.register({
  g = {
    -- lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <c-t> to jump back
    h = { '<cmd>Lspsaga lsp_finder<cr>', '(lspsaga)find the symbol definition implementation references' },
    -- rename
    r = { '<cmd>Lspsaga rename<cr>', '(lspsaga)rename' },
    -- peek definition
    -- you can edit the definition file in this flaotwindow
    -- also support open/vsplit/etc operation check definition_action_keys
    -- support tagstack c-t jump back
    d = { '<cmd>Lspsaga peek_definition<cr>', '(lspsaga)peek definition' },
  },
  ['<leader>'] = {
    name = '(lspsaga/trouble/coq/telescope/code runner/dap/hlslens/codewindow)',
    -- Show cursor diagnostic
    cd = { '<cmd>Lspsaga show_cursor_diagnostics<CR>', '(lspsaga)show cursor diagnostics' },
    o = { '<cmd>LSoutlineToggle<CR>', '(lspsaga)Mini map (Outline)' },
  },
  ['['] = {
    -- Diagnsotic jump can use `<c-o>` to jump back
    e = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', '(lspsaga)jump to prev diagnostic' },
    -- Only jump to error
    E = { function() require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
      '(lspsaga)jump to prev error' },
  },
  [']'] = {
    e = { '<cmd>Lspsaga diagnostic_jump_next<CR>', '(lspsaga)jump to next diagnostic' },
    E = { function() require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
      '(lspsaga)jump to next error' },
  },
  K = { '<cmd>Lspsaga hover_doc<CR>', '(lspsaga)hover doc' },
  ['<A-d>'] = { '<cmd>Lspsaga open_floaterm<CR>', '(lspsaga)open float term' },
})

wk.register({
  ['<leader>'] = {
    -- Code action
    ca = { '<cmd>Lspsaga code_action<CR>', '(lspsaga)code action' },
  },
}, { mode = { 'n', 'v' } })

wk.register({
  -- close floaterm
  ['<A-d>'] = { [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], '(lspsaga)close floaterm' }
}, { mode = 't' })
