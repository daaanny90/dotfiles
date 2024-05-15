return {
  "gbprod/phpactor.nvim",
  build = function()
    require("phpactor.handler.update")()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    language_server_code_transform = {
      import_name = {
        report_non_exsisting_names = false,
      },
    },
    code_transform = {
      indentation = " ",
    },
  },
}
