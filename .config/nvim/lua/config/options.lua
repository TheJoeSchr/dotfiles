-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Set the localleader key to <space>
vim.g.maplocalleader = ","
-- SPACE as leader key
vim.g.mapleader = " "

-- disable all snack animations
vim.g.snacks_animate = false

-- set to `true` to follow the main branch
-- you need to have a working rust toolchain to build the plugin
-- in this case.
vim.g.lazyvim_blink_main = true

-- Set 24-bit colors
vim.o.termguicolors = true

--
-- set the python host for neovim
vim.cmd([[ let g:python3_host_prog = expand('/usr/bin/python') ]])
--  save on focus lost
vim.cmd([[au FocusLost * silent! wa]])

local opt = vim.opt

-- Clipboard
-- Explicitly set Clipboard
-- Also fixes if SSH_TTY is set in tmux session by mobile app
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
-- Predefine clipboard provider to speedup start
vim.g.clipboard = {
  name = "xsel",
  copy = {
    ["+"] = "xsel --nodetach -i -b",
    ["*"] = "xsel --nodetach -i -p",
  },
  paste = {
    ["+"] = "xsel -o -b",
    ["*"] = "xsel -o -b",
  },
  cache_enabled = 1,
}
-- clipboard overrides is needed as sometimes SSH_TTY is set in tmux session by mobile app
-- We need to customize the clipboard depending on whether in tmux, in SSH_TTY or not.
--  In Tmux, there are 2 clipboard providers
--  1. Tmux
--  2. OSC52 should also work by default.
--  In SSH_TTY, OSC 52 should work, but needs to be overridden as I use Alacritty.
--  In local (not SSH session), LazyVim default clipboard providers can be used.
--   Sample references -
--   https://github.com/folke/which-key.nvim/issues/584 - Has references to when clipboard is modified
--   Some more info here - https://www.reddit.com/r/neovim/comments/17rbbec/neovim_nightly_now_you_can_copy_via_ssh_with/
--
--
--  You can test OSC 52 in terminal by using following in your terminal
--  printf $'\e]52;c;%s\a' "$(base64 <<<'hello world')"
local is_tmux_session = vim.env.TERM_PROGRAM == "tmux" -- Tmux is its own clipboard provider which directly works.
-- TMUX documentation about its clipboard - https://github.com/tmux/tmux/wiki/Clipboard#the-clipboard
if vim.env.SSH_TTY and not is_tmux_session then
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  local osc52 = require("vim.ui.clipboard.osc52")

  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end
-- -- Show matching brackets.
opt.showmatch = true
-- -- Do smart case matching
opt.smartcase = true
-- -- Set completion options
opt.completeopt = { "menuone", "noselect", "popup" }
-- Set tabstop and shiftwidth
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2
opt.shiftwidth = 2

-- views can only be fully collapsed with the global statusline (avante)
opt.laststatus = 3

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

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = false
  opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldmethod = "expr"
  opt.foldtext = ""
end
