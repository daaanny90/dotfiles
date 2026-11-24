-- Neovim profile for writing markdown.
-- Launch with: NVIM_APPNAME=notes nvim <file.md>

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Prose-friendly options
local opt = vim.opt
opt.number = false
opt.relativenumber = false
opt.signcolumn = "no"
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.conceallevel = 2
opt.scrolloff = 8
opt.spell = true
opt.spelllang = { "it", "en", "de" }

-- Move by visual line on wrapped text, unless a count is given
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Bootstrap lazy.nvim (plugins live in ~/.local/share/notes, separate from the main config)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "daaanny90/zed.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("zed").setup({ transparent = true })
      vim.cmd.colorscheme("zed-macos-classic-dark")
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle zen mode" } },
    opts = {
      window = { width = 80 },
      plugins = { tmux = { enabled = true } },
    },
  },
}, {
  install = { colorscheme = { "zed-macos-classic-dark" } },
  change_detection = { notify = false },
})

-- Open zen mode automatically on markdown buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.schedule(function()
      if not require("zen-mode.view").is_open() then
        require("zen-mode").open()
      end
    end)
  end,
})

-- zen-mode has no exit hook: close it on quit so tmux status/zoom get restored
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if require("zen-mode.view").is_open() then
      require("zen-mode").close()
    end
  end,
})
