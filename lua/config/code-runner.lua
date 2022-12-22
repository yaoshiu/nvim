local wk = require('which-key')
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
