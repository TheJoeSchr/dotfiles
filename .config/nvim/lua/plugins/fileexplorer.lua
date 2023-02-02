local plugins =
  ' NNN_PLUG="f:finder;o:fzopen;P:mocplay;p:fzplug;z:autojump;j:autojump;d:diffs;t:nmount;v:preview-tui;x:xdgdefault;l:launch"'
local apps = ' PAGER="bat --style=plain"'
-- # -a autosetup share selection (see NNN_FIFO)
-- # -x
-- #         show notifications on selection cp, mv, rm completion (requires .ntfy plugin)
-- #         copy path to system clipboard on selection (requires .cbcp plugin)
-- #         show xterm title (if non-picker mode)
-- # -c cli-only NNN_OPENER (trumps -e)
-- # -r use advcpmv patched cp, mv
-- #
-- # UNUSED
-- # -u use selection if available, don't prompt to choose between selection and hovered entry
-- # -n nav-by-type
-- # -J disable auto-advance on selection (eg. selecting an entry will no longer move cursor to the next entry)
-- # -H hidden files
-- # -D show directories in context color with NNN_FCOLORS set
-- # -p takes output file as an argument
-- # - print to stdout
-- # `-p -` print selected to stdout
-- with preview-tui ' -P v',
-- "nnn -J -axcr -H -p -"
local nnn_cmd = plugins .. apps .. " nnn -H"
local nnn_cmd_picker = nnn_cmd .. " -J -axcr -p -"

return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    enabled = true,
    lazy = false,
    keys = {
      {
        "-",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      { "<leader>fE", "<cmd>Neotree toggle<CR>", desc = "Explorer NeoTree (cwd)" },
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
        follow_current_file = true,
      },
    },
  },
  -- file explorer
  {
    "luukvbaal/nnn.nvim",
    enabled = true,
    keys = {
      -- <C-n> =>harpoon
      -- { "<C-n>", "<leader>fP", desc = "File Explorer NNN(cwd)", remap = true },
      { "<leader>e", "<leader>fP", desc = "File Explorer NNN(cwd)", remap = true },
      { "<leader>fP", "<cmd>NnnPicker<CR>", desc = "NNN Picker" },
      { "<leader>fp", "<cmd>NnnExplorer<CR>", desc = "NNN Explorer (root dir)" },
    },
    opts = {
      -- cmd = "nnn", -- command overrride (-F1 flag is implied, -a flag is invalid!)
      picker = {
        cmd = nnn_cmd_picker,
      },
      -- cmd = "nnn",
      explorer = {
        cmd = nnn_cmd,
        -- cmd = 'EDITOR=nvim VISUAL=vmux NNN_PLUG="f:finder;o:fzopen;P:mocplay;p:fzplug;j:autojump;d:diffs;t:nmount;v:preview-tui;x:xdgdefault;l:launch" PAGER="bat --style=plain" nnn -E -J -axcr -H',
      },
      auto_open = {
        setup = nil, -- or "explorer" / "picker", auto open on setup function
        tabpage = nil, -- or "explorer" / "picker", auto open when opening new tabpage
        empty = false, -- only auto open on empty buffer
        ft_ignore = { -- dont auto open for these filetypes
          "gitcommit",
        },
      },
      auto_close = false, -- close tabpage/nvim when nnn is last window
      replace_netrw = "explorer", -- or "explorer" / "picker"
      mappings = {}, -- table containing mappings, see below
      windownav = { -- window movement mappings to navigate out of nnn
        left = "<C-w>h",
        right = "<C-w>l",
        next = "<C-w>w",
        prev = "<C-w>W",
      },
      offset = true, -- whether or not to write position offset to tmpfile(for use in preview-tui)
    },
  },
}
