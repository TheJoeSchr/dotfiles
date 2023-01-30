local wk = require("which-key")

local function set_commands()
  vim.cmd("command! DiagnosticPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! DiagnosticNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! DiagnosticLine lua vim.diagnostic.open_float({ source = true })")
end

local function set_keymaps()
  wk.register({
    x = {
      name = "Diagnostics",
      L = { "<cmd>DiagnosticLine<CR>", "show 'Diagnostics' for current line" },
      n = { "<cmd>DiagnosticNext<CR>", "jump 'Diagnostics' to next" },
      p = { "<cmd>DiagnosticPrev<CR>", "jump 'Diagnostics' to previous" },
      E = { "<cmd>DiagnosticLine<CR>", "show 'Diagnostics' diagnostic for current line" },
    },
  }, {
    prefix = "<leader>",
  })
  wk.register({
    E = { "<cmd>DiagnosticLine<CR>", "show diagnostic for current line" },
  })
end

local function set_signs()
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
end

set_commands()
set_keymaps()
set_signs()
vim.diagnostic.config({
  virtual_text = false,
})

return {}
