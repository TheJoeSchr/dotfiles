-- Turns off netrw
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_netrwSettings = 0
vim.g.loaded_netrwFileHandlers = 0

-- EASYMOTION
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>l",
  "<Plug>(easymotion-lineforward)",
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
-- local wk = require("which-key")
--
-- wk.register({
--   e = {
--     name = "Easymotion",
--   },
--   {
--     prefix = "<leader>",
--   },
-- })
--
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
