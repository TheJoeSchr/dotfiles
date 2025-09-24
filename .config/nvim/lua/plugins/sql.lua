return {
  -- https://www.josean.com/posts/neovim-linting-and-formatting
  "mason-org/mason.nvim",
  -- format
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    -- Don't override plugin.config directly, since this will break LazyVim formatting.
    opts = function()
      ---@type conform.setupOpts
      local opts = {
        formatters_by_ft = {
          sql = { "sqruff" },
        },
      }
      return opts
    end,
  },
  -- SQL DB autocompete and ui
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  { -- optional saghen/blink.cmp completion source
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          sql = { "snippets", "dadbod", "buffer" },
        },
        -- add vim-dadbod-completion to your completion providers
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
  },
  -- lint
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        sql = { "sqruff" },
      }

      -- lint.linters.postgrestools.args = {
      --   "check",
      -- }
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    ensure_installed = {
      "sqruff",
    },
    ignore_install = { "sqlfluff" },
  },
}
