local wk = require('which-key')
require 'trouble'.setup {}
wk.register({
  ['<leader>x'] = {
    name = 'trouble',
    x = { '<cmd>TroubleToggle<cr>', '(trouble)Open trouble' },
    w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', '(trouble)Open trouble with workspace diagnostics' },
    d = { '<cmd>TroubleToggle document_diagnostics<cr>', '(trouble)Open trouble with document diagnostics' },
    l = { '<cmd>TroubleToggle loclist<cr>', '(trouble)Open trouble with location list' },
    q = { '<xmd>TroubleToggle quickfix<cr>', '(trouble)Open trouble with quickfix' },
  },
  g = {
    R = { '<cmd>TroubleToggle lsp_references<cr>', '(trouble)Open trouble with lep references' },
  },
})
