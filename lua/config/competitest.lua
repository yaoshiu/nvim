local wk = require('which-key')
require('competitest').setup()
wk.register({
  ['<leader>t'] = {
    name = '(competitest)',
    r = { '<cmd>CompetiTestRun<cr>', '(competitest)run competitest'},
    t = {
      name = 'testcase',
      a = { '<cmd>CompetiTestAdd<cr>', '(competitest)add test' },
      e = { '<cmd>CompetiTestEdit<cr>', '(competitest)edit test' },
      d = { '<cmd>CompetiTestDelete<cr>', '(competitest)remove test' },
      r = { '<cmd>CompetiTestReceive<cr>', '(competitest)receive test' },
    }
  }
})
