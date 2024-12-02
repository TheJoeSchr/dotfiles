-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
    { "echasnovski/mini.pick", version = false },
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
    { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
  },
  config = function()
    -- Plugin setup
    require("codecompanion").setup({
      -- General settings
      load_on_startup = true, -- Ensures the plugin loads at startup

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
