-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local wk = require("which-key")

-- Movement and Navigation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })
vim.keymap.set("n", "<C-y>", "<C-d>", { desc = "Scroll down" })

-- Buffer Operations
vim.keymap.set("n", "<C-s>", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format buffer" })
vim.keymap.set("n", "<C-S>", "<cmd>write<CR>", { desc = "Save buffer" })

-- Other LSP mappings
wk.add({
  { "<leader>gg", "<cmd>G<CR>", { desc = "Git status" } },
  { "<leader>gdd", "<cmd>Gvdiffsplit<CR>", { desc = "Diff vsplit" } },
  { "<leader>gd3", "<cmd>Gvdiffsplit<CR>", { desc = "3-way diff vsplit" } },
})
