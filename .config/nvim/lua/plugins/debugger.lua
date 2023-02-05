-- local wk = require("which-key")
-- local function set_keymaps()
--   wk.register({
--     d = {
--       name = "debugger",
--       b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Set Breakpoint" },
--       B = {
--         "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
--         "Conditional Breakpoint",
--       },
--       s = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
--       n = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
--       o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
--       u = { "<cmd>lua require('dap').up()<CR>", "Up" },
--       d = { "<cmd>lua require('dap').down()<CR>", "Down" },
--       q = { "<cmd>lua require('dap').terminate()<CR>", "Terminate" },
-- " nnoremap <leader>dt :TestNearest -strategy=jest<CR>
--     },
--     D = {
--       D = { "<cmd>lua require('dap').continue()<CR>", "Start/Continue" },
--     },
--   }, {
--     prefix = "<leader>",
--   })
-- end
--
return {
  -- -- DEBUGGER ----
  {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
    },
    keys = { D = { D = { "<cmd>lua require('dap').continue()<CR>", "Start/Continue" } }, prefix = "<leader>" },
  },

  -- {
  --   dependencies = {
  --     "rcarriga/nvim-dap-ui",
  --     "theHamsta/nvim-dap-virtual-text",
  --     "mfussenegger/nvim-dap-python",
  --   },
  --   keys = {
  --     { "d", "debugger" },
  --     { "D", "debugger" },
  --   },
  --   config = true,
  --   -- config = function()
  --   --   set_keymaps()
  --   -- end,
  -- },
}
