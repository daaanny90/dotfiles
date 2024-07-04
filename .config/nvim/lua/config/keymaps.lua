-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Escape with KJ
vim.keymap.set("i", "kj", "<ESC>", { silent = true })

-- Rest.nvim
vim.keymap.set("n", "<leader>rr", "<Plug>RestNvim")

-- neotest
vim.keymap.set(
  "n",
  "<leader>twr",
  "<cmd>lua require('neotest').run.run({ vitestCommand = 'vitest --watch' })<cr>",
  { desc = "Run Watch" }
)

vim.keymap.set(
  "n",
  "<leader>twf",
  "<cmd>lua require('neotest').run.run({ vim.fn.expand(' % '), vitestCommand = 'vitest --watch' })<cr>",
  { desc = "Run Watch File" }
)

-- Generate diagram
vim.keymap.set("n", "<leader>O", "<Plug>GenerateDiagram")

-- svg preview
vim.keymap.set("n", "<leader>cs", "<cmd>PreviewSvg<cr>", { desc = "Preview SVG" })
