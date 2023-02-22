-- messes up autocompletion
if true then
  return {}
end
local lsp = require("lsp-zero").preset({
  name = "recommended",
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = "local",
  sign_icons = {
    error = "✘",
    warn = "▲",
    hint = "⚑",
    info = "",
  },
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
