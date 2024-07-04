-- inline git blame like in vscode
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 0,
      },
      current_line_blame_formatter = "<author> • <author_time> • <summary>",
    },
  },
}
