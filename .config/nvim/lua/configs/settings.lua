------------------------
-- BEHAVIORAL SETTINGS -
------------------------

local M = {}

local function set_options()
  -- Set 24-bit colors
  vim.o.termguicolors = true
  -- vim.cmd([[colorscheme onedark]])
  vim.cmd[[colorscheme tokyonight]]
  --
  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  })
  -- [[  Set background transparent  ]]
  -- maybe can use `vim.api.nvim_set_hl` instead
  vim.cmd([[hi Normal guibg=None ctermbg=None]])
  vim.cmd([[  hi NonText ctermbg=NONE  ]])
  -- -- Show matching brackets.
  -- vim.o.showmatch = true
  -- -- Do smart case matching
  -- vim.o.smartcase = true
  -- -- Allow resizing of the window on session restore
  -- vim.opt.sessionoptions:append({ 'resize' })
  -- -- Give popup menus for a right mouse-click
  -- vim.o.mousemodel = 'popup_setpos'
  -- -- Hide buffers when they are not displayed; this prevents warning messages
  -- -- about modified buffers when switching between them.
  -- vim.o.hidden = true
  -- -- Set the spelling language to US English.
  -- vim.o.spelllang = 'en_us'
  -- -- Highlight the line on which the cursor lies
  -- vim.o.cursorline = true
  -- -- Show line numbers
  -- vim.o.number = true
  -- -- Don't show insert mode; taken care of by lualine
  -- vim.o.showmode = false

  -- -- Use the persistent-undo feature
  -- vim.o.undofile = true
  -- -- Maximum number of changes that can be undone
  -- vim.o.undolevels = 1000
  -- -- Maximum number lines to save for undo on a buffer reload
  -- vim.o.undoreload = 10000

  -- -- Decrease the time to update the swap file
  -- vim.o.updatetime = 500

  -- -- Enable concealing, for example, rendering bold text in Markdown but hiding
  -- -- the asterisks
  -- vim.o.conceallevel = 2

  -- -- Leave most folds open by default.
  -- vim.o.foldlevelstart = 99

  -- -- Increase cmdheight
  -- vim.o.cmdheight = 2

  -- -- Set completion options
  -- vim.opt.completeopt = { 'menuone', 'noselect' }

  -- -- Set the leader key to <space>
  -- vim.g.mapleader = ' '
end

function M.setup()
  set_options()
end

return M
