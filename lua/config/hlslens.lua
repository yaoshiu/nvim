local wk = require('which-key')
require('hlslens').setup()

local kopts = {noremap = true, silent = true}
wk.register({
  n = { [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], '(hlslens)next' },
  N = { [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], '(hlslens)prev' },
  ['*'] = { [[*<Cmd>lua require('hlslens').start()<CR>]], '(hlslens)search forward' },
  ['#'] = { [[#<Cmd>lua require('hlslens').start()<CR>]], '(hlslens)search backword' },
  g = {
    ['*'] = { [[g*<Cmd>lua require('hlslens').start()<CR>]], '(hlslens)go to search forward' },
    ['#'] = { [[g#<Cmd>lua require('hlslens').start()<CR>]], '(hlslens)go to search backword' },
  },
  ['<leader>l'] = { [[<Cmd>noh<CR>]], '(hlslens)hide hlslens' },
})
