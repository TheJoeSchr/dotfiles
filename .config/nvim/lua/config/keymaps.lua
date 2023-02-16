local v = require("utils/maps") -- Options are automatically loaded before lazy.nvim startup
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- MINE

-- Copilot
vim.keymap.set("i", "<C-g>", "<cmd>ChatGPTCompleteCode<CR>", { silent = true })
--
-- https://github.com/ThePrimeagen/init.lua
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- (visual) J/K to move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- keep cursor in place when concatenating lines
vim.keymap.set("n", "J", "mzJ`z")
-- keep cursor in place when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever (keep register when pasting)
vim.keymap.set({ "x", "v" }, "<leader>p", [["_dP]])
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>ap", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "tmux sessionizer" })

vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })

-- MINE
vim.keymap.set("n", "<C-s>", "<cmd>LspZeroFormat<CR>")
-- save (and autoformat)
vim.keymap.set("n", "<C-S>", "<cmd>write<CR>")
-- -- Ctrl-y to scroll down (like in chrome/onehand)
vim.keymap.set("n", "<C-y>", "<C-d>")

-- fugitive (git)
vim.keymap.set("n", "<leader>gL", "<cmd>:0Gclog<CR>", { desc = "fugitive file[L]og in quickfix" })
vim.keymap.set("n", "<leader>gl", "<cmd>:Gclog<CR>", { desc = "fugitive [L]og in quickfix" })
vim.keymap.set("n", "<leader>GG", "<cmd>:G<CR>", { desc = "fugitive G" })
vim.keymap.set("n", "<leader>gG", "<cmd>:G<CR>", { desc = "fugitive G" })
vim.keymap.set("n", "<leader>gg", "<cmd>:G<CR>", { desc = "fugitive G" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "fugitive [L]og" })
-- 3 way split (merge conflict, use `dp` & `do` to send hunks between diffs)
vim.keymap.set("n", "<leader>gd3", "<cmd>:Gvdiffsplit<CR>", { desc = "[G]it: [3] way [d]iff split" })
vim.keymap.set("n", "<leader>gdd", "<cmd>:Gdiff<CR>", { desc = "Diff" })
