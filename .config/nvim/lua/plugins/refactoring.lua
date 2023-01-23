-- Remaps for the refactoring operations currently offered by the plugin
-- vim.api.nvim_set_keymap(
--   "v",
--   "<leader>re",
--   [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
--   { noremap = true, silent = true, expr = false }
-- )
-- vim.api.nvim_set_keymap(
--   "v",
--   "<leader>rf",
--   [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
--   { noremap = true, silent = true, expr = false }
-- )
-- vim.api.nvim_set_keymap(
--   "v",
--   "<leader>rv",
--   [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
--   { noremap = true, silent = true, expr = false }
-- )
-- vim.api.nvim_set_keymap(
--   "v",
--   "<leader>ri",
--   [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
--   { noremap = true, silent = true, expr = false }
-- )

-- -- Extract block doesn't need visual mode
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>rb",
--   [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
--   { noremap = true, silent = true, expr = false }
-- )
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>rbf",
--   [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
--   { noremap = true, silent = true, expr = false }
-- )

-- -- Inline variable can also pick up the identifier currently under the cursor without visual mode
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>ri",
--   [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
--   { noremap = true, silent = true, expr = false }
-- )

-- -- prompt for a refactor to apply when the remap is triggered
-- vim.api.nvim_set_keymap(
--   "v",
--   "<leader>rr",
--   ":lua require('refactoring').select_refactor()<CR>",
--   { noremap = true, silent = true, expr = false }
-- )
local refactoring = require("refactoring")
local wk = require("which-key")

local function set_keymaps()
  wk.register({
    r = {
      name = "refactoring",
      e = {
        function()
          refactoring.refactor("Extract Function")
        end,
        "[E]xtract function",
      },
      f = {
        function()
          refactoring.refactor("Extract Function To [F]ile")
        end,
        "extract function to file",
      },
      v = {
        function()
          refactoring.refactor("Extract Variable")
        end,
        "extract [V]ariable",
      },
      i = {
        function()
          refactoring.refactor("Inline Variable")
        end,
        "[I]nline variable",
      },
      r = {
        function()
          refactoring.select_refactor()
        end,
        "select [R]efactoring",
      },
    },
  }, {
    prefix = "<leader>",
    mode = "v",
  })
  wk.register({
    r = {
      name = "refactoring",
      b = {
        function()
          refactoring.refactor("Extract Block")
        end,
        "extract [B]lock",
      },
      f = {
        function()
          refactoring.refactor("Extract Block To File")
        end,
        "extract function to [F]ile",
      },
      i = {
        function()
          refactoring.refactor("Inline Variable")
        end,
        "[I]nline variable",
      },
    },
  }, {
    prefix = "<leader>",
  })
end

set_keymaps()

return {
  "ThePrimeagen/refactoring.nvim",
  config = true,
  keys = {
    { "<leader>r", desc = "[R]efactor" },
  },
  opts = {
    prompt_func_return_type = {
      go = false,
      java = false,

      cpp = false,
      c = false,
      h = false,
      hpp = false,
      cxx = false,
    },
    prompt_func_param_type = {
      go = false,
      java = false,

      cpp = false,
      c = false,
      h = false,
      hpp = false,
      cxx = false,
    },
    printf_statements = {},
    print_var_statements = {},
  },
}
