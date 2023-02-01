-- Turns off netrw
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_netrwSettings = 0
vim.g.loaded_netrwFileHandlers = 0

-- EASYMOTION
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>l",
  "<Plug>(easymotion-lineforward)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>j",
  "<Plug>(easymotion-j)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>k",
  "<Plug>(easymotion-k)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>h",
  "<Plug>(easymotion-linebackward)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>w",
  "<Plug>(easymotion-w)",
  { noremap = true, silent = false, expr = false }
)
vim.keymap.set(
  { "o", "v", "n", "s" },
  "<LocalLeader>b",
  "<Plug>(easymotion-b)",
  { noremap = true, silent = false, expr = false }
)
-- local wk = require("which-key")
--
-- wk.register({
--   e = {
--     name = "Easymotion",
--   },
--   {
--     prefix = "<leader>",
--   },
-- })
--
return {
  -- Easymotion fuzzy search
  {
    "easymotion/vim-easymotion",
    event = "VimEnter",
    dependencies = {
      "haya14busa/incsearch.vim",
      "haya14busa/incsearch-fuzzy.vim",
      "haya14busa/incsearch-easymotion.vim",
    },
    keys = {

      { "<Leader>E", "<Plug>(easymotion)" },
      { "<Leader>L", "<Plug>(easymotion-lineforward)" },
      { "<Leader>J", "<Plug>(easymotion-j)" },
      { "<Leader>K", "<Plug>(easymotion-k)" },
      { "<Leader>H", "<Plug>(easymotion-linebackward)" },
      { "<Leader>W", "<Plug>(easymotion-w)" },
      { "<Leader>B", "<Plug>(easymotion-b)" },
      { "<Leader>E", "<Plug>(easymotion-e)" },
    },
  },
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous Hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous Hunk" })
        map("n", "<leader>gt", gs.toggle_deleted, "Show edited/deleted text")
      end,
    },
    current_line_blame = false,
    keys = {
      {
        "]c",
        desc = "Previous Hunk",
      },
    },
    -- map({ "n", "v" }, "<leader>g=", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    -- map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    -- map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
    -- map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
    -- map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
    -- map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
    -- map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
    -- map("n", "<leader>gd", gs.diffthis, "Diff This")
    -- map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
  },
}
