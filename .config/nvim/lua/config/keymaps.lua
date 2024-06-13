-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Escape with KJ
vim.keymap.set("i", "kj", "<ESC>", { silent = true })

-- Rest.nvim
vim.keymap.set("n", "<leader>rr", "<Plug>RestNvim")
