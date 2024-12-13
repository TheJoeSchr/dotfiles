local trouble = require("trouble")
local wk = require("which-key")

local function set_keymaps()
  wk.add({
    ["<leader>x"] = { name = "Trouble" },
    ["<leader>xx"] = { "<cmd>Trouble<cr>", "open / jump to" },
    ["<leader>xc"] = { "<cmd>TroubleClose<cr>", "close" },
    ["<leader>xw"] = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace diagnostics" },
    ["<leader>xd"] = { "<cmd>Trouble document_diagnostics<cr>", "document_diagnostics" },
    ["<leader>xl"] = { "<cmd>Trouble loclist<cr>", "location list" },
    ["<leader>xq"] = { "<cmd>Trouble quickfix<cr>", "quickfix" },
    -- ["<leader>xr"] = { "<cmd>Trouble lsp_references<cr>", "LSP references" },
  })
end

set_keymaps()
return {
  "folke/trouble.nvim",
}
