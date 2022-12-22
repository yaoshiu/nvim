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
