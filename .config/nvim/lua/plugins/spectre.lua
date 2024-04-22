-- search and replace plugin
return {
  "nvim-pack/nvim-spectre",
  requires = "nvim-lua/plenary.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    is_block_ui_break = true,
  },
}
