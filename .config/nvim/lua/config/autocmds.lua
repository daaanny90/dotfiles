-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- In Herole Vue projects, the formatting must be done only from eslint.
-- For this reason, volar is used only for intellisense and snippets, but
-- autoformatting must be deactivated if eslint lsp is attached.
local lsp_conficts, _ = pcall(vim.api.nvim_get_autocmds, { group = "LspAttach_conflicts" })
if not lsp_conficts then
  vim.api.nvim_create_augroup("LspAttach_conflicts", {})
end
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_conflicts",
  desc = "prevent eslint and volar competing for formatting",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local active_clients = vim.lsp.get_active_clients()
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- test to always stop tsserver. if it works, must be packed in a neovimrc to
    -- handle this case only for herole projects with vue (or general vue projects)
    for _, client_ in pairs(active_clients) do
      if client_.name == "tsserver" then
        print("stop tsserver")
        client_.stop()
      end
    end

    -- prevent eslint and volar competing
    if client.name == "volar" then
      print("volar is already attached")
      for _, client_ in pairs(active_clients) do
        -- stop volar autoformat if eslint is already active
        if client_.name == "eslint" then
          print("eslint found. stopping volar formatting")
          client.server_capabilities.documentFormattingProvider = false
        end

        if client_.name == "tsserver" then
          print("stopping tsserver while volar is attached")
          client_.stop()
        end
      end

      -- prevent tsserver and volar to competing
      if client.name == "tsserver" then
        print("tsserver is already attached")
        for _, client_ in pairs(active_clients) do
          -- stop tsserver if volar is attached
          if client_.name == "volar" then
            print("volar found. stopping tsserver")
            client.stop()
          end
        end
      end
    end
  end,
})

-- avoid the automatic insert mode when a file is opened with telescope
-- https://github.com/nvim-telescope/telescope.nvim/issues/2027#issuecomment-1561836585
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})

-- Autoupdate plugins if needed
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
    if require("lazy.status").has_updates then
      require("lazy").update({ show = false })
    end
  end,
})

vim.keymap.set("n", "<leader>O", "<Plug>GenerateDiagram")
