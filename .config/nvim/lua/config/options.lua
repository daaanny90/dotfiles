-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.tabby_keybinding_accept = "<tab>"

vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})
