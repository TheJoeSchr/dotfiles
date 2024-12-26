-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "echasnovski/mini.pick", version = false },
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
    {
      "saghen/blink.cmp",
      dependencies = { "saghen/blink.compat" },
      opts = {
        enabled = function()
          return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
        end,
        sources = {
          compat = { "codecompanion" },
          providers = {
            codecompanion = {
              name = "CodeCompanion",
              module = "codecompanion.providers.completion.blink",
              enabled = true,
            },
          },
        },
      },
    },
  },
  config = function()
    -- Plugin setup
    require("codecompanion").setup({
      -- General settings
      load_on_startup = false, -- Ensures the plugin loads at startup

      -- Adapter configuration
      adapter = {
        name = "anthropic", -- Use Anthropic as the adapter
      },

      -- Strategy configuration
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
        code_assist = "anthropic",
        code_review = "anthropic",
        completion = "anthropic",
        debugging = "anthropic",
      },
    })

    -- Key mappings
    local keymap = vim.keymap.set

    -- Normal mode mappings
    keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "Open Code Companion Actions" })
    keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle Code Companion Chat" })
    keymap("n", "<LocalLeader>c", "<cmd>CodeCompanionChat Clear<cr>", { desc = "Clear Code Companion Chat" })

    -- Visual mode mappings
    keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "Open Code Companion Actions" })
    keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle Code Companion Chat" })
    keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add Selection to Code Companion Chat" })
  end,
}
