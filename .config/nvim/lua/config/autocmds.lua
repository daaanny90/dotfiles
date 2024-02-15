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
    -- prevent eslint and volar competing
    if client.name == "volar" then
      for _, client_ in pairs(active_clients) do
        -- stop volar autoformat if eslint is already active
        if client_.name == "eslint" then
          client.server_capabilities.documentFormattingProvider = false
        end
      end
    end
  end,
})
