return {
  "saghen/blink.cmp",
  dependencies = { "saghen/blink.compat" },
  opts = {
    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {},
      default = { "lsp", "path", "snippets", "buffer" },
      cmdline = {},
    },

    keymap = {
      preset = "default",
    },
  },
}
