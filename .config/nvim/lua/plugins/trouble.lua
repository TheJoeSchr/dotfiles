local trouble = require("trouble")
local wk = require("which-key")

local function set_keymaps()
  wk.register({
    ["<leader>t"] = {
      name = "Trouble",
      t = { "<cmd>Trouble<cr>", "Open/Jump to" },
      c = { "<cmd>TroubleClose<cr>", "Close" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
      d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
      l = { "<cmd>Trouble loclist<cr>", "Location List" },
      q = { "<cmd>Trouble quickfix<cr>", "Quickfix" },
    },
  })
end

set_keymaps()
return {
  "folke/trouble.nvim",
}
