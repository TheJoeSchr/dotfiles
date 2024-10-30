return {
  -- sidebar file explorer (using "-")
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    enabled = true,
    lazy = false,
    keys = {
      {
        "-",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root.get() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      { "_", "<cmd>Neotree toggle<CR>", desc = "Explorer NeoTree (cwd)" },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
    },
  },
  -- file picker
  {
    "rolv-apneseth/tfm.nvim",
    lazy = false,
    opts = {
      -- TFM to use
      -- Possible choices: "ranger" | "nnn" | "lf" | "vifm" | "yazi" (default)
      file_manager = "yazi",
      -- Replace netrw entirely
      -- Default: false
      replace_netrw = true,
      -- Enable creation of commands
      -- Default: false
      -- Commands:
      --   Tfm: selected file(s) will be opened in the current window
      --   TfmSplit: selected file(s) will be opened in a horizontal split
      --   TfmVsplit: selected file(s) will be opened in a vertical split
      --   TfmTabedit: selected file(s) will be opened in a new tab page
      enable_cmds = false,
      -- Custom keybindings only applied within the TFM buffer
      -- Default: {}
      keybindings = {
        ["<ESC>"] = "q",
        -- Override the open mode (i.e. vertical/horizontal split, new tab)
        -- Tip: you can add an extra `<CR>` to the end of these to immediately open the selected file(s) (assuming the TFM uses `enter` to finalise selection)
        ["<C-v>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.vsplit)<CR>",
        ["<C-x>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.split)<CR>",
        ["<C-t>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.tabedit)<CR>",
      },
      -- Customise UI. The below options are the default
      ui = {
        border = "rounded",
        height = 1,
        width = 1,
        x = 0.5,
        y = 0.5,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("tfm").open()
        end,
        desc = "TFM",
      },
      {
        "<leader>pp",
        function()
          require("tfm").open()
        end,
        desc = "TFM",
      },
      {
        "<leader>ph",
        function()
          local tfm = require("tfm")
          tfm.open(nil, tfm.OPEN_MODE.split)
        end,
        desc = "TFM - horizontal split",
      },
      {
        "<leader>pv",
        function()
          local tfm = require("tfm")
          tfm.open(nil, tfm.OPEN_MODE.vsplit)
        end,
        desc = "TFM - vertical split",
      },
      {
        "<leader>pt",
        function()
          local tfm = require("tfm")
          tfm.open(nil, tfm.OPEN_MODE.tabedit)
        end,
        desc = "TFM - new tab",
      },
    },
  },
}
