-- -- DEBUGGER ----
-- "puremourning/vimspector",
-- -- DEBUGGER ----
-- "puremourning/vimspector",
local wk = require("which-key")
local function set_keymaps()
  wk.register({
    d = {
      name = "debugger",
      b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Set Breakpoint" },
      B = {
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        "Conditional Breakpoint",
      },
      s = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
      n = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
      o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
      u = { "<cmd>lua require('dap').up()<CR>", "Up" },
      d = { "<cmd>lua require('dap').down()<CR>", "Down" },
      q = { "<cmd>lua require('dap').terminate()<CR>", "Terminate" },
    },
    D = {
      D = { "<cmd>lua require('dap').continue()<CR>", "Start/Continue" },
    },
  }, {
    prefix = "<leader>",
  })
end

-- -- DEBUGGER ----
-- "puremourning/vimspector",
-- {
--   "theHamsta/nvim-dap-virtual-text",
--   opts = {
--     enabled = true, -- enable this plugin (the default)
--     enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
--     highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
--     highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
--     show_stop_reason = true, -- show stop reason when stopped for exceptions
--     commented = true, -- prefix virtual text with comment string
--     only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
--     all_references = false, -- show virtual text on all all references of the variable (not only definitions)
--     filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
--     -- experimental features:
--     virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
--     all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
--     virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
--     virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
--     -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
--   },
-- },

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    set_keymaps()
  end,
}
