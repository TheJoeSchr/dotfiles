local wk = require("which-key")

local function set_commands()
  vim.cmd("command! DiagnosticPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! DiagnosticNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! DiagnosticLine lua vim.diagnostic.open_float({ source = true })")
end

local function set_keymaps()
  wk.add({
    ["<leader>x"] = {
      name = "Diagnostics",
      L = { "<cmd>DiagnosticLine<CR>", "Show diagnostics for current line" },
      n = { "<cmd>DiagnosticNext<CR>", "Jump to next diagnostic" },
      p = { "<cmd>DiagnosticPrev<CR>", "Jump to previous diagnostic" },
      E = { "<cmd>DiagnosticLine<CR>", "Show diagnostic details" },
    },
  })
  wk.add({
    E = { "<cmd>DiagnosticLine<CR>", "Show diagnostic for current line" },
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
