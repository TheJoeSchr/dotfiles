-- -- DEBUGGER ----
-- "puremourning/vimspector",
local wk = require("which-key")
local function set_keymaps()
  k =
    { "<cmd>lua require('dap').step_out()<CR>", "Step Out" }, wk.register({
      d = {
        name = "debugger",
        b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Set Breakpoint" },
        B = {
          "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
          "Conditional Breakpoint",
      { "<leader>te", "<cmd>Telescope file_browser<CR>", desc = "Telescope File Browser" },
        },
        E = { "<Cmd>lua require('dapui').eval()<CR>", "Eval" },
        j = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
        l = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
        q = { "<cmd>lua require('dap').terminate()<CR>", "Terminate" },
        r = { "<cmd>lua require('dap').repl.open({}, 'split')()<CR>", "[R]epl split" },
        -- nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
      },
      D = {
        D = { "<cmd>lua require('dap').continue()<CR>", "Start/Continue" },
      },
      F5 = { "<cmd>lua require('dap').continue()<CR>", "Start/Continue" },
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
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- DAP for LUA
      { "jbyuki/one-small-step-for-vimkind" },
      { "mfussenegger/nvim-dap-python" },
      { "nvim-telescope/telescope-dap.nvim", keys = { "<leader>dd", desc = "DAP Debug" } },
      {
        "theHamsta/nvim-dap-virtual-text",
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)

        -- experimental features:
        virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = true, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      },
      -- " Mappings DAPU
      --   " expand = { "<CR>", "<2-LeftMouse>" },
      --   " open = "o",
      --   " remove = "d",
      --   " edit = "e",
      --   " repl = "r",
      --   " toggle = "t",
      --   " eg inscopes press 'o' to open a variable
      {
        "rcarriga/nvim-dap-ui",
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle()
            end,
            desc = "DAP UI",
          },
        },
      },
    },
    config = function()
      set_keymaps()
    end,
  },
  { "folke/neodev.nvim", opts = { library = { plugins = { "nvim-dap-ui" }, types = true } } },
}
