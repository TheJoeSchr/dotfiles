return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
      { "folke/neodev.nvim" },
      -- { "nvimtools/none-ls.nvim" },
      { "jose-elias-alvarez/nvim-lsp-ts-utils" },
      --
      { "simrat39/inlay-hints.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-buffer" }, -- Optional
      { "hrsh7th/cmp-path" }, -- Optional
      { "saadparwaiz1/cmp_luasnip" }, -- Optional
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "hrsh7th/cmp-nvim-lua" }, -- Optional

      -- Snippets
      { "L3MON4D3/LuaSnip" }, -- Required
      { "rafamadriz/friendly-snippets" }, -- Optional
      -- tiny pictograms for lsp completion items
      { "onsails/lspkind.nvim" }, -- Optional

      -- Native LSP formatting
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
}
