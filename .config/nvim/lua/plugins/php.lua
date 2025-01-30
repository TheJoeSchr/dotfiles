return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Add Intelephense for PHP LSP
        phpactor = {},
      },
    },
  },
  -- Snippets support
  {
    "SirVer/ultisnips",
    dependencies = { "honza/vim-snippets" },
  },
  -- PHP syntax highlighting
  {
    "StanAngeloff/php.vim",
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/.local/sources/vscode-php-debug/out/phpDebug.js" },
      }
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for XDebug (system-dap)",
          port = 9003,
          log = true,
          pathMappings = {
            ["/var/www/html/"] = vim.fn.getcwd() .. "/",
          },
          hostname = "0.0.0.0",
        },
      }
      require("dap.ext.vscode").load_launchjs()
    end,
  },
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        php = { "php-cs-fixer" },
      },
      formatters = {
        ["php-cs-fixer"] = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
            "$FILENAME",
          },
          stdin = false,
        },
      },
      notify_on_error = true,
    },
  },
}
