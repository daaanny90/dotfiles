return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
  },
  opts = {
    adapters = {
      ["neotest-vitest"] = {
        is_test_file = function(file_path)
          -- Check if the project is "my-peculiar-project"
          if string.match(file_path, "kundenportal") then
            -- Check if the file path includes something else
            return string.match(file_path, "/src/")
          end
          return true
        end,
      },
    },
  },
}
