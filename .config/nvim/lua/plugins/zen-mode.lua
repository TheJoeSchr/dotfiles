return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<C-w>O", ":ZenMode<CR>", desc = "ZenMode" },
  },
  dependencies = {
    { "folke/twilight.nvim", event = "VeryLazy", opts = { context = 15 } },
    "lewis6991/gitsigns.nvim",
    "folke/lsp-colors.nvim",
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    window = {
      backdrop = 0.75, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      -- height and width can be:
      -- * an absolute number of cells when > 1
      -- * a percentage of the width / height of the editor when <= 1
      -- * a function that returns the width or the height
      width = 0.55, -- width of the Zen window
      height = 0.9, -- height of the Zen window
      -- by default, no options are changed for the Zen window
      -- uncomment any of the options below, or add other vim.wo options you want to apply
      options = {
        -- signcolumn = "no", -- disable signcolumn
        number = true, -- disable number column
        relativenumber = true, -- disable relative numbers
        cursorline = true, -- disable cursorline
        cursorcolumn = true, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      -- disable some global vim options (vim.o...)
      -- comment the lines to not apply the options
      options = {
        enabled = true,
        ruler = false, -- disables the ruler text in the cmd line area
        showcmd = false, -- disables the command in the last line of the screen
      },
      twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = false }, -- disables the tmux statusline
      -- this will change the font size on kitty when in zen mode
      -- to make this work, you need to set the following kitty options:
      -- - allow_remote_control socket-only
      -- - listen_on unix:/tmp/kitty
      kitty = {
        enabled = false,
        font = "+4", -- font size increment
      },
      -- this will change the font size on alacritty when in zen mode
      -- requires  Alacritty Version 0.10.0 or higher
      -- uses `alacritty msg` subcommand to change font size
      alacritty = {
        enabled = true,
        font = "14", -- font size
      },
    },
    -- callback where you can add custom code when the Zen window opens
    on_open = function(win) end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function() end,
  },
}
