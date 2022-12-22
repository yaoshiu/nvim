local wk = require('which-key')
local codewindow = require('codewindow')
codewindow.setup()
wk.register({
  ['<leader>m'] = {
    o = { codewindow.open_minimap, '(codewindow)open minimap' },
    c = { codewindow.close_minimap, '(codewindow)close minimap' },
    f = { codewindow.focus, '(codewindow)focus/unfocus minimap' },
    m = { codewindow.toggle_minimap, '(codewindow)toggle minimap' },
  },
})
