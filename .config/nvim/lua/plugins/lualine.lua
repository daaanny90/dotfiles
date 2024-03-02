return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local function show_codeium_status()
      return "{…}" .. vim.fn["codeium#GetStatusString"]()
    end

    local function show_macro_recording()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      else
        return "Recording @" .. recording_register
      end
    end

    require("lualine").setup({
      sections = {
        lualine_x = {
          { show_codeium_status },
        },
        lualine_b = {
          { "branch" },
          { "macro-recording", fmt = show_macro_recording },
        },
      },
    })
  end,
}
