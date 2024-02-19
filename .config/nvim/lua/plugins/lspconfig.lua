return {
  "neovim/nvim-lspconfig",
  opts = {
    -- This configuration is added to use eslint as formatter on save. There where conflicts between eslint and formatter in herole project
    servers = { eslint = {}, volar = {}, yamlls = {} },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
      yamlls = function()
        require("lspconfig").yamlls.setup({
          settings = {
            yaml = {
              format = {
                enable = true,
                singleQuote = false,
                bracketSpacing = false,
              },
            },
          },
        })
      end,
    },
  },
}
