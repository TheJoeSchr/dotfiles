-- // https://yobibyte.github.io/vim.html
--
-- a seamless integration with the terminal so that you could grep/find/build your project and direct the output to your editor without any hassle.
--
-- I have this seamless integration by having a simple custom binding that creates a scratch buffer, runs a command, and sends the output to that scratch buffer:


--nread pipe input buffer
vim.keymap.set("n", "<localleader>s", function()
    vim.ui.input({}, function(c)
        if c and c~="" then
            vim.cmd("noswapfile vnew")
          vim.bo.buftype = "nofile"
          vim.bo.bufhidden = "wipe"
          vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
        end
    end)
end)

-- I can even get rid of this binding and just use ":vnew | read !cmd", but I do not want to manually close that buffer.





-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.vtl",
  command = "set ft=velocity",
})

-- Help Neovim check if file has changed on disk
-- https://github.com/neovim/neovim/issues/2127
local checktime_group = vim.api.nvim_create_augroup("cspciwciwllacehecktime", { clear = true })
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
