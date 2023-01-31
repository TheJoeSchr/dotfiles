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
-- one small step for humankind (lua dap)
dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
  },
}

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end
-- " nnoremap <leader>dt :TestNearest -strategy=jest<CR>
require("dap.ext.vscode").load_launchjs()
-- "" find local virtualenv
require("dap-python").setup(string.format("%s/bin/python", os.getenv("VIRTUAL_ENV")))

vim.fn.sign_define("DapBreakpoint", { text = "🤖", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▸", texthl = "", linehl = "", numhl = "" })
require("dapui").setup()
