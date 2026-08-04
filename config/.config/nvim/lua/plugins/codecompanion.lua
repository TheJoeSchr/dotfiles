return {
  "olimorris/codecompanion.nvim",
  opts = {
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG", -- or "TRACE"
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "zbirenbaum/copilot.lua",
    { "ibhagwan/fzf-lua" },
    {
      -- Stop memorizing prompt names or hunting through files.
      -- This plugin gives you a beautiful, fast picker with rich
      -- markdown previews that shows you exactly what each prompt
      -- does before you use it. Think Telescope for files, but for your AI prompts.
      "3ZsForInsomnia/code-companion-picker",
      dependencies = { "folke/snacks.nvim" },
      opts = {
        picker = "snacks",
      },
      keys = {
        { "n", "<leader>cp", "<cmd>CodeCompanionPrompts<cr>", desc = "Browse CodeCompanion Prompts" },
      },
    },
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
    {
      -- https://www.reddit.com/r/neovim/comments/1hrsrdm/having_issues_installing_blinkcmp/
      -- You need to build the fuzzy matching library which is written in rust. For that, you need cargo and rustup. Then install nightly with rustup.
      -- Then write into your lazy config:
      --
      -- {
      --     'saghen/blink.cmp',
      --     build = 'cargo +nightly build --release'
      -- }
      -- Works for me.
      --
      -- If you want to use the stable version (version = '*') remove the +nightly . Either way, you need to build the rust packages for the fuzzy match library, if you have this issue.
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
          default = { "lsp", "path", "snippets", "buffer", "cmdline", "omni", "lazydev" },
        },
        completion = {
          accept = {
            auto_brackets = {
              kind_resolution = {
                blocked_filetypes = { "typescriptreact", "javascriptreact", "vue", "codecompanion" },
              },
            },
          },
        },
        keymap = {
          preset = "default",
        },
      },
    },
  },
  config = function()
    -- Expand 'cc' into 'CodeCompanion' in the command line
    -- Errors on loadup, so disabled for now.
    vim.cmd([[cab cc CodeCompanion]])
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
          adapter = "copilot",
        },
        code_assist = "anthropic",
        code_review = "anthropic",
        completion = "copilot",
        debugging = "anthropic",
      },
    })

    -- Key mappings
    local wk = require("which-key")
    wk.add({
      {
        mode = { "n" }, -- NORMAL a
        { "<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "Open Code Companion Actions" } },
        { "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle Code Companion Chat" } },
        { "<LocalLeader>c", "<cmd>CodeCompanionChat Clear<cr>", { desc = "Clear Code Companion Chat" } },
      },
      {
        mode = { "v" }, -- VISUAL v
        { "<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "Open Code Companion Actions" } },
        { "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle Code Companion Chat" } },
        { "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add Selection to Code Companion Chat" } },
      },
    })
  end,
}
