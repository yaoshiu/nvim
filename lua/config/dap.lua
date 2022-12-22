local wk = require('which-key')
local dap = require'dap'
wk.register({
  ['<F5>'] = { dap.continue, '(dap)continue/start debugging' },
  ['<F10>'] = { dap.step_over, '(dap)step over' },
  ['<F11>'] = { dap.step_into, '(dap)step into' },
  ['<F12>'] = { dap.step_out, '(dap)step out' },
  ['<leader>'] = {
    b = { dap.toggle_breakpoint, '(dap)toggle breakpoint' },
    B = { function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, '(dap)set breakpoint with condition' },
    lp = { function()
      dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end, '(dap)set breakpoint with message' },
    dr = { dap.repl.open, '(dap)open a repl/debug-console' },
    dl = { dap.run_last, '(dap)rerun the debug last time' },
  },
})

require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
wk.register({
  ['<M-k>'] = { require'dapui'.eval, '(dap ui)evaluate expression' },
}, { mode = 'v', silent = false})
--vim.keymap.set('v', '<M-k>', require 'dapui'.eval, { noremap = true, silent = false })

-- goto breakpoints
--map('n', '<leader>]d', require('goto-breakpoints').next, {})
--map('n', '<leader>[d', require('goto-breakpoints').prev, {})
wk.register({
  ['<leader>]'] = {
    name = 'next',
    d = { require'goto-breakpoints'.next, 'go to next breakpoint(goto breakpoints)' },
  },
  ['<leader>['] = {
    name = 'prev',
    d = { require'goto-breakpoints'.prev, 'go to prev breakpoint(goto breakpoints)' },
  },
})

-- presistent breakpoints
require('persistent-breakpoints').setup {
  load_breakpoints_event = { "BufReadPost" }
}
