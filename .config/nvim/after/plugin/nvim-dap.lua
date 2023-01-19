local dap = require("dap")
-- find vscode setup
require("dap.ext.vscode").load_launchjs()
-- manually configure different testrunner if auto-detect fails
--find local virtualenv
require("dap-python").setup(string.format("%s/bin/python", os.getenv("VIRTUAL_ENV")))
require("dap-python").test_runner = "pytest"

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
