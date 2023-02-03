local v = require("utils/maps") -- Options are automatically loaded before lazy.nvim startup
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- MINE
-- md2pdf
-- TODO: make extension
-- md2pdf NAME.md && okular NAME.pdf
-- just format -- Set the Enter key to Space v.nmap("<CR>", " ")
vim.keymap.set("n", "<C-s>", "<cmd>LspZeroFormat<CR>")
-- save (and autoformat)
vim.keymap.set("n", "<C-S>", "<cmd>write<CR>")
-- Q closes buffer => ui/CloseBuffers
-- requies("ui/CloseBuffers")

-- no such mapping?
-- vim.keymap.del("v", "<M-h>")
-- vim.keymap.del("v", "<M-j>")
-- vim.keymap.del("v", "<M-k>")
-- vim.keymap.del("v", "<M-l>")

-- fugitive (git)
vim.keymap.set("n", "<leader>gL", "<cmd>:0Gclog<CR>", { desc = "fu[g]itive file[L]og in quickfix" })
vim.keymap.set("n", "<leader>gl", "<cmd>:Gclog<CR>", { desc = "fu[g]itive [L]og in quickfix" })
vim.keymap.set("n", "<leader>GG", "<cmd>:G<CR>", { desc = "fu[g]itive [G]" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "fu[g]itive [L]og" })
-- 3 way split (merge conflict, use `dp` & `do` to send hunks between diffs)
vim.keymap.set("n", "<leader>gd3", "<cmd>:Gvdiffsplit<CR>", { desc = "[G]it: [3] way [d]iff split" })
vim.keymap.set("n", "<leader>gdd", "<cmd>:Gdiff<CR>", { desc = "Diff" })
-- https://github.com/ThePrimeagen/init.lua
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- (visual) J/K to move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- keep cursor in place when concatenating lines
vim.keymap.set("n", "J", "mzJ`z")
-- keep cursor in place when scrolling
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-f>", "<C-f>zz")
-- vim.keymap.set("n", "<C-b>", "<C-b>zz")
-- keep cursor in place when searching
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
-- -- Ctrl-y to scroll down (like in chrome/onehand)
vim.keymap.set("n", "<C-y>", "<C-d>")

-- greatest remap ever (keep register when pasting)
vim.keymap.set({ "x", "v" }, "<leader>p", [["_dP]])
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Ctrl-c to escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })
