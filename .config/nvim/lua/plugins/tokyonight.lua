-- Default LazyVim theme made by Folke
return {
  -- "folke/tokyonight.nvim",
  -- opts = {
  --   transparent = true,
  --   styles = {
  --     sidebars = "transparent",
  --     floats = "transparent",
  --     style = "storm",
  --   },
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "tokyonight",
  --   },
  -- },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      functionStyle = { bold = true },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
          wave = {},
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          Boolean = { bold = false },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    },
  },
  -- "rebelot/kanagawa.nvim",
  -- priority = 1000,
  -- name = "kanagawa",
  -- lazy = false,
  -- config = function()
  --   require("kanagawa").setup({
  --     compile = true,
  --     functionStyle = { bold = true },
  --     dimInactive = true,
  --     colors = {
  --       theme = {
  --         all = {
  --           ui = {
  --             bg_gutter = "none",
  --           },
  --         },
  --       },
  --     },
  --   })
  --   vim.cmd("colorscheme kanagawa-wave")
  -- vim.cmd("colorscheme kanagawa-dragon")
  -- vim.cmd("colorscheme kanagawa-lotus")
  -- end,
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-wave",
      -- colorscheme = "kanagawa-dragon",
      -- colorscheme = "kanagawa-lotus",
    },
  },
}
