-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

-- Set the Enter key to Space
v.nmap("<CR>", " ")

-- md2pdf
-- TODO: make extension
-- md2pdf NAME.md && okular NAME.pdf

-- no such mapping?
vim.keymap.del("v", "<M-h>")
vim.keymap.del("v", "<M-j>")
vim.keymap.del("v", "<M-k>")
vim.keymap.del("v", "<M-l>")

-- keep cursor in place when scrolling
-- makes me dizy
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
-- Ctrl-c to escape
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
