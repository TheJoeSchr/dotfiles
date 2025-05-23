-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.vtl",
  command = "set ft=velocity",
})

-- Help Neovim check if file has changed on disk
-- https://github.com/neovim/neovim/issues/2127
local checktime_group = vim.api.nvim_create_augroup("checktime", { clear = true })
if vim.fn.has("gui_running") == 0 then
  vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "BufEnter", "FocusLost", "WinLeave" }, {
    group = checktime_group,
    pattern = "*",
    command = "checktime",
  })
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "plugins.lua",
  command = "source <afile> | Lazy sync",
})
