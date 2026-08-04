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

local exts = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  -- using pwa-chrome
  "vue",
  "svelte",
}

for _, ext in ipairs(exts) do
  dap.configurations[ext] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Program (pwa-node)",
      cwd = vim.fn.getcwd(),
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Program (pwa-node with ts-node)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "--loader", "ts-node/esm" },
      runtimeExecutable = "node",
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Program (pwa-node with deno)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
      runtimeExecutable = "deno",
      attachSimplePort = 9229,
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Program (pwa-node with jest)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
      runtimeExecutable = "node",
      args = { "${file}", "--coverage", "false" },
      rootPath = "${workspaceFolder}",
      sourceMaps = true,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Program (pwa-node with vitest)",
      cwd = vim.fn.getcwd(),
      program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
      args = { "run", "${file}" },
      autoAttachChildProcesses = true,
      smartStep = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Program (pwa-node with deno)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
      runtimeExecutable = "deno",
      attachSimplePort = 9229,
    },
    {
      type = "pwa-chrome",
      request = "attach",
      name = "Attach Program (pwa-chrome = { port: 9222 })",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
    {
      type = "node2",
      request = "attach",
      name = "Attach Program (Node2)",
      processId = require("dap.utils").pick_process,
    },
    {
      type = "node2",
      request = "attach",
      name = "Attach Program (Node2 with ts-node)",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      port = 9229,
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach Program (pwa-node)",
      cwd = vim.fn.getcwd(),
      processId = require("dap.utils").pick_process,
      skipFiles = { "<node_internals>/**" },
    },
  }
end
-- notify.warn dap.ext.vscode.load_launchjs is deprecated
-- as it is no longer needed. ./.vscode/launch.json files
-- are read automatically on-demand. See :help dap-providers
-- require("dap.ext.vscode").load_launchjs()

-- "" find local virtualenv

local dapPython = require("dap-python")
dapPython.test_runner = "pytest"
dapPython.setup(string.format("%s/bin/python", os.getenv("VIRTUAL_ENV")))
dapPython.test_runner = "pytest"
-- " nnoremap <leader>dt :TestNearest -strategy=jest<CR>
vim.keymap.set("n", "<leader>dtt", dapPython.test_method, { desc = "dapPython.test_method" })

vim.fn.sign_define("DapBreakpoint", { text = "🤖", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▸", texthl = "", linehl = "", numhl = "" })
require("dapui").setup()
