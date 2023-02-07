if true then
  return {}
end
local M = {}

local cmp_lsp = require("cmp_nvim_lsp")
local lsp_format = require("lsp-format")
local nvim_lsp = require("lspconfig")
local navic = require("nvim-navic")
local wk = require("which-key")

-- also after/lsp.lua
local function set_keymaps(bufnr)
  wk.register({
    c = {
      name = "LSP code",
      a = { "<cmd>CodeActionMenu<CR>", "code actions" },
      f = { "<cmd>Format<CR>", "format" },
      D = { "<cmd>LspTypeDef<CR>", "type definition" },
      L = { "<cmd>LspDeclaration<CR>", "declaration" },
      t = {
        name = "LSP [T]elescope",
        d = { "<cmd>Telescope lsp_definitions<CR>", "definitions" },
        r = { "<cmd>Telescope lsp_references<CR>", "references" },
        i = { "<cmd>Telescope lsp_implementations<CR>", "implementations" },
      },
      -- not working?
      w = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "[W]orkspace Symbols" },
    },
  }, {
    prefix = "<leader>",
    buffer = bufnr,
  })
  wk.register({
    K = { "<cmd>LspHover<CR>", "LSP hover" },
  }, {
    buffer = bufnr,
  })
end

set_keymaps()
function M.setup()

  nvim_lsp.pyright.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })

  nvim_lsp.vimls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })

  nvim_lsp.omnisharp.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })
end
return M
