-- navigation sidebar
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    auto_close = true,
    update_to_buf_dir = {
      enable = true,
    },
    window = {
      position = "right",
    },
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          -- '.git',
          -- '.DS_Store',
          -- 'thumbs.db',
        },
        never_show = {},
      },
    },
    update_focused_file = {
      enable = true,
    },
  },
}
