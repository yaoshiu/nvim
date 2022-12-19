---@diagnostic disable: redefined-local
-- global vim settings
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.cindent = true
vim.o.number = true
vim.o.signcolumn = 'yes'
vim.g.mapleader = ','

-- packer.nvim
require('plugins')

--which-key
local wk = require('which-key')

-- navic
local navic = require('nvim-navic')
navic.setup {}

-- mason/lspinstaller
require('mason').setup()
require('mason-lspconfig').setup({
  automatic_installation = true
})

-- lspconfig
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
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
--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
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

  --  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  --  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  --  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  --  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --  vim.keymap.set('n', '<space>wl', function()
  --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --  end, bufopts)
  --  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  --  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  --  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  --  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- navic on_attach
  if client.server_capabilities.documentSymbolProvider then
    print("lsp and navic attached")
    navic.attach(client, bufnr)
  end
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require 'lspconfig'.pyright.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { "pyright-langserver", "--stdio", "--ignoreexternal"}
} --Python
require 'lspconfig'.clangd.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --C/C++
require 'lspconfig'.jdtls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --Java
require 'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --Lua
require 'lspconfig'.ltex.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --LaTeX
require 'lspconfig'.marksman.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --Markdown
--require 'lspconfig'.sqlls.setup {
--  on_attach = on_attach,
--  flags = lsp_flags,
--} --SQL
require 'lspconfig'.yamlls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --YAML
require 'lspconfig'.jsonls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} --JSON
require 'lspconfig'.sqls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
} -- SQL(sqls)
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

-- Lspsaga
local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.init_lsp_saga()

wk.register({
  g = {
    -- Lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    h = { '<cmd>Lspsaga lsp_finder<CR>', '(lspsaga)find the symbol definition implementation references' },
    -- Rename
    r = { '<cmd>Lspsaga rename<CR>', '(lspsaga)rename' },
    -- Peek Definition
    -- you can edit the definition file in this flaotwindow
    -- also support open/vsplit/etc operation check definition_action_keys
    -- support tagstack C-t jump back
    d = { '<cmd>Lspsaga peek_definition<CR>', '(lspsaga)peek definition' },
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
-- keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
-- keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
--keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
--keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
--keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
--keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
--keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
--keymap("n", "[E", function()
--  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
--end, { silent = true })
--keymap("n", "]E", function()
--  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
--end, { silent = true })
--keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })
-- Hover Doc
--keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- Float terminal
--keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
--keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
--keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

-- nvim-lightbulb
require('nvim-lightbulb').setup({
  autocmd = { enabled = true },
})

-- trouble
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
--vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
--  {silent = true, noremap = true}
--)
--vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
--  {silent = true, noremap = true}
--)
--vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
--  {silent = true, noremap = true}
--)
--vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
--  {silent = true, noremap = true}
--)
--vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
--  {silent = true, noremap = true}
--)
--vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
--  {silent = true, noremap = true}
--)

-- coq
vim.g.coq_settings = {
  keymap = { 
    eval_snips = '<leader>j',
    recommended = false,
  },
  clients = {
    tabnine = { enabled = true },
  },
}
wk.register({
  ['<leader>j'] = '(coq)evulate snippet (Only in snippet files)',
})

-- treesitter
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { 'c', 'cpp', 'lua', 'go', 'java', 'python' },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
  -- ts rainbow
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

-- tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  open_on_setup = true,
  sort_by = "extension",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  tab = {
    sync = {
      close = true,
      open = true,
    },
  },
})
-- autoclose solution @rwblokzijl
local function tab_win_closed(winnr)
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
      ---@diagnostic disable-next-line: undefined-global
      api.tree.close()
    end
  else -- else closed buffer was normal buffer
    if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
        vim.schedule(function()
          if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
            vim.cmd "quit" -- then close all of vim
          else -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})

-- lsp colors
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

-- telescope
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

--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
require 'telescope'.setup {}

-- telescope-file-browser
require 'telescope'.load_extension 'file_browser'
wk.register({
  ['<space>f'] = {
    b = { '<cmd>Telescope file_browser<cr>', '(telescope)file browser' },
  },
})
--vim.api.nvim_set_keymap(
--  "n",
--  "<space>fb",
--  ":Telescope file_browser<cr>",
--  { noremap = true }
--)

-- telescope-dotfiles
require 'telescope'.load_extension 'dotfiles'

-- colorizer
require 'colorizer'.setup()

-- shade
-- require'shade'.setup({
--  overlay_opacity = 50,
--  opacity_step = 1,
--  keys = {
--    brightness_up    = '<C-Up>',
--    brightness_down  = '<C-Down>',
--    toggle           = '<Leader>s',
--  }
--})

-- lualine
require('lualine').setup {
  options = {
    theme = 'material',
  },
  sections = {
    lualine_c = {
      { navic.get_location, cond = navic.is_available }
    }
  }
}

-- barbar
local map = vim.api.nvim_set_keymap
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

--map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
--map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
--map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
--map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
--map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
--map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
--map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
--map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
--map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
--map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
--map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
--map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
--map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
--map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
--map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
--map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
--map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
--map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
--map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
--map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
--map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
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

-- cursorline
require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}

-- dashboard
local home = os.getenv('HOME')
local db = require('dashboard')
-- linux
db.preview_command = 'ueberzug'
db.preview_file_path = home .. '/.config/nvim/img/gravatar.png'
db.preview_file_height = 15
db.preview_file_width = 20
db.custom_center = {
  { icon = '  ',
    desc = 'Recently latest session                  ',
    shortcut = 'SPC s l',
    action = 'SessionLoad' },
  { icon = '  ',
    desc = 'Recently opened files                   ',
    action = 'Telescope oldfiles',
    shortcut = 'SPC f h' },
  { icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f f' },
  { icon = '  ',
    desc = 'File Browser                            ',
    action = 'Telescope file_browser',
    shortcut = 'SPC f b' },
  { icon = '  ',
    desc = 'Find  word                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f w' },
  { icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'Telescope dotfiles path=' .. home .. '/.dotfiles',
    shortcut = 'SPC f d' },
}

-- code runner
require('code_runner').setup({
  -- put here the commands by filetype
  startinsert = true,
  filetype = {
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = "python3 -u",
    typescript = "deno run",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
    cpp = "cd $dir && g++ -std=c++17 $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
    c = "cd $dir && g++ -std=c++17 $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
  },
})
wk.register({
  ['<leader>'] = {
    r = { '<Cmd>RunCode<CR>', '(code runner)run code' },
    rf = { '<Cmd>RunFile<CR>', '(code runner)run file' },
    rft = { '<Cmd>RunFile tab<CR>', '(code runner)run file on new tab' },
    rp = { '<Cmd>RunProject<CR>', '(code runner)run project'},
    rc = { '<Cmd>RunClose<CR>', '(code runner)close runner' },
    crf = { '<Cmd>CRFileType<CR>', '(code runner)open json with supported files' },
    cfp = { '<Cmd>CRProjects<CR>', '(code runner)open json with list of projects' },
  },
}, {silent = false})

--vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
--vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
--vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
--vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
--vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
--vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
--vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })

-- mason nvim dap
require('mason-nvim-dap').setup({
  automatic_installation = true,
  automatic_setup = true,
})


-- dap
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
--vim.keymap.set('n', '<F5>', require 'dap'.continue, { noremap = true, silent = true })
--vim.keymap.set('n', '<F10>', require 'dap'.step_over, { noremap = true, silent = true })
--vim.keymap.set('n', '<F11>', require 'dap'.step_into, { noremap = true, silent = true })
--vim.keymap.set('n', '<F12>', require 'dap'.step_out, { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint, { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>B', function() require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
--  { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>lp',
--  function() require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
--  { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>dr', require 'dap'.repl.open, { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>dl', require 'dap'.run_last, { noremap = true, silent = true })


-- dap ui
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
local map = vim.keymap.set
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

-- hlslens
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
--vim.api.nvim_set_keymap('n', 'n',
--    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
--    kopts)
--vim.api.nvim_set_keymap('n', 'N',
--    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
--    kopts)
--vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
--vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
--vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
--vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
--
--vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

-- scrollview
require('scrollview').setup()

-- codewindow
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

-- autotag
require('nvim-ts-autotag').setup()

-- autopairs
local npairs = require('nvim-autopairs')
npairs.setup({ map_bs = false, map_cr = false })
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
wk.register({
  ['<bs>'] = { MUtils.BS, '<bs>' },
  ['<cr>'] = { MUtils.CR, '<cr>'}
}, { mode = 'i', expr = true })

-- treesitter context
require'treesitter-context'.setup()

-- web devicons
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

-- mini ai
require('mini.ai').setup()

-- color scheme
require('material').setup({
  lualine_style = 'default',
  contrast = {
    cursor_line = true, -- Enable darker background for the cursor line
  },
  styles = { -- Give comments style such as bold, italic, underline etc.
    comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true },
  },
  plugins = { -- Uncomment the plugins that you use to highlight them
    -- Available plugins:
    "dap",
    "dashboard",
    -- "gitsigns",
    -- "hop",
    -- "indent-blankline",
    "lspsaga",
    -- "mini",
    -- "neogit",
    -- "nvim-cmp",
    "nvim-navic",
    "nvim-tree",
    "nvim-web-devicons",
    -- "sneak",
    "telescope",
    "trouble",
    "which-key",
  },
  async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
})
vim.g.material_style = 'palenight'
vim.cmd 'colorscheme material'
--vim.g.neon_style = "default"
--vim.g.neon_italic_keyword = true
--vim.g.neon_italic_function = true
--vim.g.neon_italic_boolean = true
--vim.g.neon_italic_variable = true
--vim.g.neon_bold = true
--vim.cmd[[colorscheme neon]]
