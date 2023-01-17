local M = {}

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local wk = require("which-key")

local function set_keymaps()
  wk.register({
    r = {
      name = "Refactoring",
      r = {
        telescope.extensions.refactoring.refactors,
        "[R]efacto[r]ing Options",
      },
    },
    t = {
      name = "Telescope",
      b = { builtin.buffers, "search buffers" },
      f = { builtin.find_files, "search files" },
      G = { builtin.grep_string, "grep word under cursor" },
      h = { builtin.help_tags, "search help" },
      r = { builtin.resume, "resume last search" },
      g = {
        name = "grep",
        a = { builtin.live_grep, "search all" },
        p = {
          function()
            builtin.live_grep({ glob_pattern = { "!*test*" } })
          end,
          "search production (exclude test files)",
        },
        t = {
          function()
            builtin.live_grep({ glob_pattern = { "*test*" } })
          end,
          "search tests",
        },
      },
    },
  }, {
    prefix = "<leader>",
  })
end

function M.setup()
  telescope.setup({
    defaults = {
      path_display = { "truncate" },
      mappings = {
        i = {
          ["<c-t>"] = trouble.open_with_trouble,
          ["<c-f>"] = actions.results_scrolling_down,
          ["<c-b>"] = actions.results_scrolling_up,
          ["<c-u>"] = false,
          ["<c-d>"] = false,
          ["<C-x>"] = false,
          ["<C-q>"] = actions.send_to_qflist,
        },
        n = {
          ["q"] = actions.close,
          ["<c-t>"] = trouble.open_with_trouble,
          ["<c-f>"] = actions.results_scrolling_down,
          ["<c-b>"] = actions.results_scrolling_up,
          ["<c-d>"] = actions.preview_scrolling_down,
          ["<c-u>"] = actions.preview_scrolling_up,
        },
      },
      -- file_sorter = telescope.sorters.get_fzy_sorter,
      prompt_prefix = ">>",
      color_devicons = true,

      --       file_previewer = telescope.previewers.vim_buffer_cat.new,
      --       grep_previewer = telescope.previewers.vim_buffer_vimgrep.new,
      --       qflist_previewer = telescope.previewers.vim_buffer_qflist.new,
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      fzy = {
        fuzzy = true,
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
    pickers = {
      buffers = {
        initial_mode = "normal",
        sort_lastused = true,
        sort_mru = true,
        theme = "dropdown",
        previewer = false,
        mappings = {
          i = {
            ["<c-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
    },
  })
  set_keymaps()
end

M.git_branches = function()
  require("telescope.builtin").git_branches({
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.git_delete_branch)
      map("n", "<c-d>", actions.git_delete_branch)
      return true
    end,
  })
end
telescope.load_extension("gh")
telescope.load_extension("fzf")
telescope.load_extension("dap")

-- load refactoring Telescope extension
telescope.load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
  "v",
  "<leader>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)
return M
