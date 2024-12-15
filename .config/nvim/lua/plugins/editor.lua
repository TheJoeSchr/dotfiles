-- Turns off netrw
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_netrwSettings = 0
vim.g.loaded_netrwFileHandlers = 0

-- COPILOT
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
-- vim.keymap.set("i", "<C-j>", "copilot#Accept('Tab')", { silent = true, expr = true })
-- vim.keymap.set("i", "<C-Tab>", '<C-R>=copilot#Accept("")<CR>', { desc = "Copilot Accept", silent = true })
-- vim.keymap.set("i", "<C-n>", "copilot#Next()", { silent = true, expr = true })
-- vim.keymap.set("i", "<C-e>", "copilot#Previous()", { silent = true, expr = true })
-- disable copilot for some filetypes
-- denylist

-- EASYMOTION
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>l",
  "<Plug>(easymotion-lineforward)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader><LocalLeader>l", -- "<LocalLeader>l" => blocked by conjure eval
  "<Plug>(easymotion-lineforward)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader><LocalLeader>e", -- "<LocalLeader>l" => blocked by conjure eval
  "<Plug>(easymotion-e)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>j",
  "<Plug>(easymotion-j)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>k",
  "<Plug>(easymotion-k)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>h",
  "<Plug>(easymotion-linebackward)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>w",
  "<Plug>(easymotion-w)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>b",
  "<Plug>(easymotion-b)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>B", -- => blocked by some attach?
  "<Plug>(easymotion-b)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<localleader><LocalLeader>b", -- => blocked by some attach?
  "<Plug>(easymotion-b)",
  { noremap = true, silent = false, expr = false }
)

return {
  -- Easymotion fuzzy search
  {
    "easymotion/vim-easymotion",
    event = "VimEnter",
    dependencies = {
      "haya14busa/incsearch.vim",
      "haya14busa/incsearch-fuzzy.vim",
      "haya14busa/incsearch-easymotion.vim",
    },
    keys = {
      { "<Leader>E", "<Plug>(easymotion)" },
      { "<Leader>L", "<Plug>(easymotion-lineforward)" },
      { "<Leader>J", "<Plug>(easymotion-j)" },
      { "<Leader>K", "<Plug>(easymotion-k)" },
      { "<Leader>H", "<Plug>(easymotion-linebackward)" },
      { "<Leader>W", "<Plug>(easymotion-w)" },
      { "<Leader>B", "<Plug>(easymotion-b)" },
      { "<Leader>E", "<Plug>(easymotion-e)" },
    },
  },
}
