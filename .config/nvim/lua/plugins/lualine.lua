return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local function show_codeium_status()
      return "{…}" .. vim.fn["codeium#GetStatusString"]()
    end

    require("lualine").setup({
      sections = {
        -- ...
        lualine_x = {
          { show_codeium_status },
          -- ...
        },
        -- ...
      },
    })
  end,
}
