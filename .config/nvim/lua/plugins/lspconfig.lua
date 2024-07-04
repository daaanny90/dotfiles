-- configuration for language servers
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      volar = {
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
        filetypes = {
          "vue",
        },
        settings = {
          Vue = {
            completion = {
              defaultTagNameCase = "kebabCase",
            },
          },
        },
      },
      yamlls = {},
      tsserver = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/Users/dasp/.nvm/versions/node/v18.19.0/lib/node_modules/@vue/typescript-plugin",
              languages = {
                "javascript",
                "typescript",
                "vue",
              },
            },
          },
        },
        filetypes = {
          "typescript",
          "javascript",
          "vue",
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      },
    },
    setup = {
      -- This configuration is added to use eslint as formatter on save. There where conflicts between eslint and tsserver in herole project
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
