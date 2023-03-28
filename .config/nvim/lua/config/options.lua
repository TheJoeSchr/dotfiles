-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Set the localleader key to <space>
vim.g.maplocalleader = ","
-- SPACE as leader key
vim.g.mapleader = " "

-- Set 24-bit colors
vim.o.termguicolors = true
--
-- set the python host for neovim
vim.cmd([[ let g:python3_host_prog = expand('/usr/bin/python') ]])
--  save on focus lost
vim.cmd([[au FocusLost * silent! wa]])

local opt = vim.opt
-- -- Show matching brackets.
opt.showmatch = true
-- -- Do smart case matching
opt.smartcase = true
-- -- Set completion options
opt.completeopt = { "menuone", "noselect" }

-- TJ kickstarter defaults
-- Allow resizing of the window on session restore
opt.sessionoptions:append({ "resize" })
-- Give popup menus for a right mouse-click
opt.mousemodel = "popup_setpos"
-- Hide buffers when they are not displayed; this prevents warning messages
-- about modified buffers when switching between them.
opt.hidden = true
-- Set the spelling language to US English.
opt.spelllang = "en_us"
-- Highlight the line on which the cursor lies
opt.cursorline = true
-- Don't show insert mode; taken care of by lualine
opt.showmode = false
-- Decrease the time to update the swap file
opt.updatetime = 50
-- Enable concealing, for example, rendering bold text in Markdown but hiding
-- the asterisks
opt.conceallevel = 2
-- Leave most folds open by default.
opt.foldlevelstart = 99
-- Increase cmdheight
opt.cmdheight = 4
-- Set completion options
opt.completeopt = { "menuone", "noselect" }
-- Using easymotion
opt.number = false -- Print line number
opt.relativenumber = false -- Relative line numbers
--
-- Lazy.nvim defaults
opt.sidescrolloff = 99 -- Columns of context
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
-- -- Maximum number of changes that can be undone
opt.undolevels = 10000
-- -- Maximum number lines to save for undo on a buffer reload
opt.undoreload = 10000
--
if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess = "filnxtToOFWIcC"
end
