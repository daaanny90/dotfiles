require('lspconfig').volar.setup {
  init_options = {
    vue = {
      hybridMode = true,
    },
  },
  filetypes = {
    'vue',
  },
  settings = {
    Vue = {
      completion = {
        defaultTagNameCase = 'kebabCase',
      },
    },
  },
}

require('lspconfig').tsserver.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = '/Users/dasp/.nvm/versions/node/v18.19.0/lib/node_modules/@vue/typescript-plugin',
        languages = {
          'javascript',
          'typescript',
          'vue',
        },
      },
    },
  },
  filetypes = {
    'typescript',
    'javascript',
    'vue',
  },
  single_file_support = false,
}

-- require('lspconfig').eslint.setup {}

-- format with eslint on save
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('eslint-format-on-attach', { clear = true }),
--   callback = function(event)
--     local client = vim.lsp.get_client_by_id(event.data.client_id)
--     if client.name == 'eslint' then
--       client.server_capabilities.documentFormattingProvider = true
--     elseif client.name == 'tsserver' then
--       client.server_capabilities.documentFormattingProvider = false
--     end
--   end,
-- })

-- return {
--   'neovim/nvim-lspconfig',
--   lazy = false,
--   priority = 1000,
--   opts = {
--     servers = {
--       lua_ls = {
--         settings = {
--           Lua = {
--             completion = {
--               callSnippet = 'Replace',
--             },
--           },
--         },
--       },
--       yamlls = {},
--       eslint = {},
--       volar = {
--         init_options = {
--           vue = {
--             hybridMode = true,
--           },
--         },
--         filetypes = {
--           'vue',
--         },
--         settings = {
--           Vue = {
--             completion = {
--               defaultTagNameCase = 'kebabCase',
--             },
--           },
--         },
--       },
--       tsserver = {
--         init_options = {
--           plugins = {
--             {
--               name = '@vue/typescript-plugin',
--               location = '/Users/dasp/.nvm/versions/node/v18.19.0/lib/node_modules/@vue/typescript-plugin',
--               languages = {
--                 'javascript',
--                 'typescript',
--                 'vue',
--               },
--             },
--           },
--         },
--         filetypes = {
--           'typescript',
--           'javascript',
--           'vue',
--         },
--       },
--     },
--   },
-- }
