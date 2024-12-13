local neotest = require("neotest").setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = { justMyCode = false, autoReload = { enable = true } },
      -- Command line arguments for runner
      -- Can also be a function to return dynamic values
      args = { "--log-level", "DEBUG" },
      -- Runner to use. Will use pytest if available by default.
      -- Can be a function to return dynamic value.
      -- runner = "pytest",
      -- Custom python path for the runner.
      -- Can be a string or a list of strings.
      -- Can also be a function to return dynamic value.
      -- If not provided, the path will be inferred by checking for
      -- virtual envs in the local directory and for Pipenev/Poetry configs
      -- python = ".venv/bin/python",
      -- Returns if a given file path is a test file.
      -- NB: This function is called a lot so don't perform any heavy tasks within it.
      -- is_test_file = function(file_path)
      --   ...
      -- end,
    }),
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})

local wk = require("which-key")
wk.add({
  ["<localleader>t"] = { name = "Neotest" },
  ["<localleader>ta"] = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
  ["<localleader>tf"] = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
  ["<localleader>tF"] = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
  ["<localleader>tl"] = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
  ["<localleader>tL"] = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
  ["<localleader>tt"] = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
  ["<localleader>td"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
  ["<localleader>tb"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
  ["<localleader>to"] = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
  ["<localleader>tS"] = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
  ["<localleader>ts"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
  ["<localleader>tw"] = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "[W]orkspace Symbols" },
})
