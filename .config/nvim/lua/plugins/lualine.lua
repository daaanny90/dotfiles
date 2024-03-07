local function get_codium_status()
  return "{…}" .. vim.fn["codeium#GetStatusString"]()
end

local function get_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    sections = {
      lualine_x = {
        { get_codium_status },
      },
      lualine_b = {
        { "branch" },
        {
          "macro-recording",
          fmt = get_macro_recording,
        },
      },
    },
  },
}
