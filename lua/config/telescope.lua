local wk = require('which-key')
local builtin = require('telescope.builtin')
wk.register({
  ['<leader>f'] = {
    name = 'telescope',
    f = { builtin.find_files, '(telescope)find files' },
    g = { builtin.live_grep, '(telescope)live grep' },
    b = { builtin.buffers, '(telescope)buffers' },
    h = { builtin.help_tags, '(telescope)help tags' },
  },
})

require 'telescope'.setup {}

-- telescope-file-browser
require 'telescope'.load_extension 'file_browser'
wk.register({
  ['<space>f'] = {
    b = { '<cmd>Telescope file_browser<cr>', '(telescope)file browser' },
  },
})

-- telescope-dotfiles
require 'telescope'.load_extension 'dotfiles'
