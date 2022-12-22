local wk = require('which-key')
local opts = { noremap = true, silent = true }
wk.register({
-- Move to previous/next
  ['<A-,>'] = { '<Cmd>BufferPrevious<CR>', '(barbar)previous buffer' },
  ['<A-.>'] = { '<Cmd>BufferNext<CR>', '(barbar)next buffer' },
-- Re-order to previous/next
  ['<A-<>'] = { '<Cmd>BufferMovePrevious<CR>', '(barbar)move previous' },
  ['<A->>'] = { '<Cmd>BufferMoveNext<CR>', '(barbar)move next' },
-- Goto buffer in position...
  ['<A-1>'] = { '<Cmd>BufferGoto 1<CR>', '(barbar)go to buffer 1' },
  ['<A-2>'] = { '<Cmd>BufferGoto 2<CR>', '(barbar)go to buffer 2' },
  ['<A-3>'] = { '<Cmd>BufferGoto 3<CR>', '(barbar)go to buffer 3' },
  ['<A-4>'] = { '<Cmd>BufferGoto 4<CR>', '(barbar)go to buffer 4' },
  ['<A-5>'] = { '<Cmd>BufferGoto 5<CR>', '(barbar)go to buffer 5' },
  ['<A-6>'] = { '<Cmd>BufferGoto 6<CR>', '(barbar)go to buffer 6' },
  ['<A-7>'] = { '<Cmd>BufferGoto 7<CR>', '(barbar)go to buffer 7' },
  ['<A-8>'] = { '<Cmd>BufferGoto 8<CR>', '(barbar)go to buffer 8' },
  ['<A-9>'] = { '<Cmd>BufferGoto 9<CR>', '(barbar)go to buffer 9' },
  ['<A-0>'] = { '<Cmd>BufferLast<CR>', '(barbar)go to last buffer' },
-- Pin/unpin buffer
  ['<A-p>'] = { '<Cmd>BufferPin<CR>', '(barbar)pin/unpin buffer' },
-- Close buffer
  ['<A-c>'] = { '<Cmd>BufferClose<CR>', '(barbar)close buffer' },
-- Magic buffer-picking mode
  ['<C-p>'] = { '<Cmd>BufferPick<CR>', '(barbar)buffer picking mode' },
  ['<Space>b'] = {
    name = 'barbar',
-- Sort automatically by...
    b = { '<Cmd>BufferOrderByBufferNumber<CR>', '(barbar)order buffer by buffer number' },
    d = { '<Cmd>BufferOrderByDirectory<CR>', '(barbar)order buffer by directory' },
    l = { '<Cmd>BufferOrderByLanguage<CR>', '(barbar)order buffer by language' },
    w = { '<Cmd>BufferOrderByWindowNumber<CR>', '(barbar)order buffer by window number' },
  },
})

local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

local function get_tree_size()
  return require 'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_api.set_offset(0)
end)
