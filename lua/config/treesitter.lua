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
