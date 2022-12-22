local wk = require('which-key')
local npairs = require('nvim-autopairs')
vim.g.coq_settings = {
  keymap = {
    eval_snips = '<leader>j',
    recommended = false,
  },
  clients = {
    tabnine = { enabled = true },
  },
  display = {
    ghost_text = {
      enabled = false,
    }
  }
}
wk.register({
  ['<leader>j'] = '(coq)evulate snippet (Only in snippet files)',
})
-- these mappings are coq recommended mappings unrelated to nvim-autopairs
wk.register({
  ['<esc>'] = { [[pumvisible() ? '<c-e><esc>' : '<esc>']], '<esc>' },
  ['<c-c>'] = { [[pumvisible() ? '<c-e><c-c>' : '<esc>']], '<esc>' },
  ['<tab>'] = { [[pumvisible() ? '<c-n>' : '<tab>']], '<tab>'},
  ['<s-tab>'] = { [[pumvisible() ? '<c-p>' : '<bs>']], '<s-tab>' },
}, { mode = 'i', expr = true })
_G.MUtils = {}
MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
  else
    return npairs.autopairs_cr()
  end
end
MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
MUtils.ESC = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>') .. npairs.esc('<esc>')
    else
      return npairs.esc('<c-e>') .. npairs.esc('<esc>')
    end
  else
    return npairs.esc('<esc>')
  end
end
wk.register({
  ['<bs>'] = { MUtils.BS, '<bs>' },
  ['<cr>'] = { MUtils.CR, '<cr>'}
}, { mode = 'i', expr = true })
