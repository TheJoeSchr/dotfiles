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
      {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
          -- Snippet Engine & its associated nvim-cmp source
          {
            "L3MON4D3/LuaSnip",
            build = (function()
              -- Build Step is needed for regex support in snippets
              -- This step is not supported in many windows environments
              -- Remove the below condition to re-enable on windows
              if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                return
              end
              return "make install_jsregexp"
            end)(),
          },
          "saadparwaiz1/cmp_luasnip",

          -- Adds other completion capabilities.
          --  nvim-cmp does not ship with all sources by default. They are split
          --  into multiple repos for maintenance purposes.
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-path",

          -- If you want to add a bunch of pre-configured snippets,
          --    you can use this plugin to help you. It even has snippets
          --    for various frameworks/libraries/etc. but you will have to
          --    set up the ones that are useful for you.
          "rafamadriz/friendly-snippets",
        },
      }, -- Required
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

  -- cody and sourcegraph
  {
    "sourcegraph/sg.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
    },
  },
}
