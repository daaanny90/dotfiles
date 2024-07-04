-- codeium is a sort of copilot, but free
return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.g.codeium_no_map_tab = 1
    vim.keymap.set("i", "<M-Tab>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true })
  end,
}
