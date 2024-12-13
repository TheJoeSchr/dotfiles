return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "folke/neodev.nvim" },
      { "jose-elias-alvarez/nvim-lsp-ts-utils" },
      { "simrat39/inlay-hints.nvim" },
      { "lukas-reineke/lsp-format.nvim" },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Useful status updates for LSP
      "j-hui/fidget.nvim",
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {},
      setup = {},
    },
  },

  -- Add blink.nvim for completion
  {
    "folke/blink.nvim",
    event = "VeryLazy",
    opts = {
      -- Configuration for blink.nvim
      delay = 100,
      repeat_count = 3,
    },
  },

  -- cody and sourcegraph
  {
    "sourcegraph/sg.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
    },
  },
}
