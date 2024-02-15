return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  opts = {},
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
    { "<leader>gD", "<cmd>DiffviewFileHistory %%<cr>", desc = "DiffviewFileHistory" },
  },
}
