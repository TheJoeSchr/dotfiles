local function set_keymaps()
  -- vista
  vim.keymap.set("n", "<Leader>o", "<Leader>cs")
  local wk = require("which-key")
  -- dap
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
      l = { "<cmd>Lazy<CR>", "Lazy" },
    },
    -- D = {
    --   D = { "<cmd>lua require('dap').continue()<CR>", "Start/Continue" },
    -- },
    g = {
      l = {
        "<cmd>Lazy<CR>",
        "Lazy",
      },
    },
  }, {
    prefix = "<leader>",
  })
end
set_keymaps()
return {
  "rcarriga/nvim-notify",
  opts = {
    background_colour = "#000000",
    timeout = 500,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.55)
    end,
  },
}
