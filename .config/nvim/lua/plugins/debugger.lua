return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- DAP for LUA
      { "jbyuki/one-small-step-for-vimkind" },
      -- PYTHON
      { "mfussenegger/nvim-dap-python" },
      -- RUBY
      { "suketa/nvim-dap-ruby" },
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
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
          {
            "<localleader>du",
            function()
              require("dapui").toggle()
            end,
            desc = "DAP UI",
          },
          {
            "<localleader>ds",
            function()
              require("dapui").float_element("scopes")
            end,
            desc = "Debug Scopes",
          },
          {
            "<localleader>dE",
            function()
              require("dapui").eval()
            end,
            desc = "Eval",
          },
        },
      },
    },
    keys = {
      {
        "<localleader>DD",
        function()
          require("dap").continue()
        end,
        desc = "Start/Continue",
      },
      {
        "<localleader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
        mode = "n",
        desc = "Hover (DAP)",
      },
      {
        "<localleader>dh",
        function()
          require("dap.ui.widgets").preview()
        end,
        mode = "v",
        desc = "Preview (DAP)",
      },
      {
        "<localleader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Set Breakpoint",
      },
      {
        "<localleader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional Breakpoint",
      },
      {
        "<localleader>de",
        function()
          require("dap").set_exception_breakpoints({ "all" })
        end,
        desc = "Breakpoint All Exceptions",
      },
      {
        "<localleader>dj",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<localleader>dl",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<localleader>dk",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<localleader>dq",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<localleader>dr",
        function()
          require("dap").repl.open({}, "split")
        end,
        desc = "[R]epl split",
      },
      {
        "<localleader>dc",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<localleader>DD",
        function()
          require("dap").continue()
        end,
        desc = "Start/Continue",
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      enabled = true, -- enable this plugin (the default)
      enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true, -- show stop reason when stopped for exceptions
      commented = true, -- prefix virtual text with comment string
      only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
      all_references = false, -- show virtual text on all all references of the variable (not only definitions)
      filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
      -- experimental features:
      virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
      all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
      -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    },
  },
  {
    "aaronhallaert/continuous-testing.nvim",
    -- %file will be replace with the test file
    opts = {
      notify = true, -- The default is false
      run_tests_on_setup = true, -- The default is true, run test on attach
      framework_setup = {
        javascript = {
          test_tool = "vitest", -- cwd of the executing test will be at package.json
          test_cmd = "yarn vitest run %file",
          root_pattern = "tsconfig.json", -- used to populate the root option of vitest
        },
      },
    },
  },
}
