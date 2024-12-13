local trouble = require("trouble")
local wk = require("which-key")

local function set_keymaps()
  wk.add({
    ["<leader>t"] = { group = "Trouble" },
    ["<leader>tt"] = { "<cmd>Trouble<cr>", "open / jump to" },
    ["<leader>tc"] = { "<cmd>TroubleClose<cr>", "close" },
    ["<leader>tw"] = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace diagnostics" },
    ["<leader>td"] = { "<cmd>Trouble document_diagnostics<cr>", "document_diagnostics" },
    ["<leader>tl"] = { "<cmd>Trouble loclist<cr>", "location list" },
    ["<leader>tq"] = { "<cmd>Trouble quickfix<cr>", "quickfix" },
    -- ["<leader>tr"] = { "<cmd>Trouble lsp_references<cr>", "LSP references" },
  })
end

set_keymaps()
return {
  "folke/trouble.nvim",
}
