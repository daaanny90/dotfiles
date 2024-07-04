return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      css = { "prettier" },
      scss = { "prettier" },
      vue = { "injected", "eslint_d" },
    },
    lang_to_ext = {
      vue = "vue",
    },
    formatters = {
      prettier = {
        prepend_args = { "--single-quote" },
      },
    },
  },
}
