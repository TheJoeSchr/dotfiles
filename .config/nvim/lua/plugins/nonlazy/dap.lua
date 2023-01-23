local M = {}
local wk = require("which-key")
local dap = require("dap")
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/.local/sources/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}
vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▸", texthl = "", linehl = "", numhl = "" })

require("dapui").setup()

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

set_keymaps()

return {}
