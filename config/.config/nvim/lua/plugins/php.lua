return {
  -- Format in `conform.lua`
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
      -- notify.warn dap.ext.vscode.load_launchjs is deprecated
      -- as it is no longer needed. ./.vscode/launch.json files
      -- are read automatically on-demand. See :help dap-providers
      -- require("dap.ext.vscode").load_launchjs()
    end,
  },
}
