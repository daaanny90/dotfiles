-- notifications in vim
return {
  "folke/noice.nvim",
  opts = {
    presets = {
      lsp_doc_border = true,
    },

    -- show nothing when no information is available
    -- instead of noice notification
    function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = {
          skip = true,
        },
      })

      opts.presets.lsp_doc_border = true
    end,
  },
}
