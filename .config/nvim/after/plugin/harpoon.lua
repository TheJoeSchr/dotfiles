local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { silent = false, desc = "Add file to harpoon" })
vim.keymap.set("n", "<localleader>n", mark.add_file, { silent = false, desc = "Add file to harpoon" })
vim.keymap.set("n", "<localleader>ma", mark.add_file, { silent = false, desc = "Add file to harpoon" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-t>", function()
  ui.nav_file(1)
end)
vim.keymap.set("n", "<C-n>", function()
  ui.nav_file(2)
end)
