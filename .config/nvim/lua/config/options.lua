-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- Set the localleader key to <space>
vim.g.maplocalleader = ","
-- SPACE as leader key
vim.g.mapleader = " "
-- Set 24-bit colors
vim.o.termguicolors = true
--
-- set the python host for neovim
vim.cmd([[ let g:python3_host_prog = expand('/usr/bin/python') ]])
-- [[  Set background transparent  ]]
vim.cmd([[hi Normal guibg=None ctermbg=None]]) -- maybe can use `vim.api.nvim_set_hl` instead
vim.cmd([[hi NonText ctermbg=NONE]])
--  save on focus lost
vim.cmd([[au FocusLost * silent! wa]])

-- [[ Highlight on yank ]] => already in lazy.nvim

local opt = vim.opt
-- -- Show matching brackets.
opt.showmatch = true
-- -- Do smart case matching
opt.smartcase = true
-- -- Set completion options
opt.completeopt = { "menuone", "noselect" }

-- -- Set the leader key to <space>
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--
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
--
-- opt.autowrite = true -- enable auto write
-- opt.clipboard = "unnamedplus" -- sync with system clipboard
-- opt.cmdheight = 1
-- opt.completeopt = "menu,menuone,noselect"
-- opt.conceallevel = 3 -- Hide * markup for bold and italic
-- opt.confirm = true -- confirm to save changes before exiting modified buffer
-- opt.cursorline = true -- Enable highlighting of the current line
-- opt.expandtab = true -- Use spaces instead of tabs
-- opt.formatoptions = "jcroqlnt" -- tcqj
-- opt.grepformat = "%f:%l:%c:%m"
-- opt.grepprg = "rg --vimgrep"
-- opt.guifont = "FiraCode Nerd Font:h11"
-- opt.hidden = true -- Enable modified buffers in background
-- opt.ignorecase = true -- Ignore case
-- opt.inccommand = "nosplit" -- preview incremental substitute
-- opt.joinspaces = false -- No double spaces with join after a dot
-- opt.laststatus = 0
-- opt.list = true -- Show some invisible characters (tabs...
-- opt.mouse = "a" -- enable mouse mode
-- opt.pumblend = 10 -- Popup blend
-- opt.pumheight = 10 -- Maximum number of entries in a popup
-- opt.scrolloff = 4 -- Lines of context
-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
-- opt.shiftround = true -- Round indent
-- opt.shiftwidth = 2 -- Size of an indent
-- opt.showmode = false -- dont show mode since we have a statusline
opt.sidescrolloff = 16 -- Columns of context
-- opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
-- opt.smartcase = true -- Don't ignore case with capitals
-- opt.smartindent = true -- Insert indents automatically
-- opt.spelllang = { "en" }
-- opt.splitbelow = true -- Put new windows below current
-- opt.splitright = true -- Put new windows right of current
-- opt.tabstop = 2 -- Number of spaces tabs count for
-- opt.termguicolors = true -- True color support
-- opt.timeoutlen = 300
-- -- Use the persistent-undo feature
-- opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
-- -- Maximum number of changes that can be undone
opt.undolevels = 10000
-- -- Maximum number lines to save for undo on a buffer reload
opt.undoreload = 10000
-- opt.updatetime = 200 -- save swap file and trigger CursorHold
-- opt.wildmode = "longest:full,full" -- Command-line completion mode
-- opt.winminwidth = 5 -- minimum window width
-- opt.wrap = false -- Disable line wrap
--
if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess = "filnxtToOFWIcC"
end

--
-- -- fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0
