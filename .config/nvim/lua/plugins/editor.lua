-- Turns off netrw
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_netrwSettings = 0
vim.g.loaded_netrwFileHandlers = 0

return {
  -- Easymotion fuzzy search
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = { keys = target_keys },
    config = function(_, opts)
      local hop = require("hop")
      hop.setup(opts)

      -- Create custom command for hopping to character/word matches
      vim.api.nvim_create_user_command("HopEasyMotion", function()
        local char = vim.fn.getchar()
        -- Convert numeric char code to string
        char = type(char) == "number" and vim.fn.nr2char(char) or char

        -- Create pattern based on input character type
        local pattern
        if char:match("%a") then
          -- For letters: match words starting with that letter
          -- Uppercase letters match exactly
          -- Lowercase letters match case insensitive only when the setting is enabled
          local case_flag = (opts.case_insensitive and char:match("%l")) and "\\c" or ""
          pattern = "\\v" .. case_flag .. "(<|_@<=)" .. char
        elseif char:match("[%p%s]") then
          -- For punctuation and whitespace: match them literally
          pattern = [[\V]] .. vim.fn.escape(char, "\\")
        else
          -- For other characters: match them literally
          pattern = char
        end

        ---@diagnostic disable-next-line: missing-fields
        hop.hint_patterns({
          current_line_only = false,
          multi_windows = true,
          hint_position = require("hop.hint").HintPosition.BEGIN,
        }, pattern)
      end, { desc = "Hop to words starting with input character" })
    end,
    keys = {
      -- { "<localleader>s", "<cmd>HopEasyMotion<cr>", desc = "Hop to word", mode = { "v", "n" } },
      { "<localleader>b", "<cmd>HopWordBC<cr>", desc = "Hop to word before cursor", mode = { "v", "n", "o" } },
      { "<localleader>a", "<cmd>HopWord<cr>", desc = "Hop to word in current buffer", mode = { "v", "n", "o" } },
      { "<localleader>w", "<cmd>HopWordAC<cr>", desc = "Hop to word after cursor", mode = { "v", "n", "o" } },
      { "<localleader>c", "<cmd>HopCamelCaseMW<cr>", desc = "Hop to camelCase word", mode = { "v", "n", "o" } },
      { "<localleader>k", "<cmd>HopLineBC<cr>", desc = "Hop to line up", mode = { "v", "n", "o" } },
      { "<localleader>j", "<cmd>HopLineAC<cr>", desc = "Hop to line down", mode = { "v", "n", "o" } },
      { "<localleader>f", "<cmd>HopNodes<cr>", desc = "Hop to node", mode = { "v", "n", "o" } },
      { "<localleader>/", "<cmd>HopPatternMW<cr>", desc = "Hop to pattern", mode = { "v", "n", "o" } },
      -- { "<localleader>j", "<cmd>HopVertical<cr>", desc = "Hop to location vertically", mode = { "v", "n" } },
    },
  },

  {
    "folke/flash.nvim",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        -- no "x", so nvim-surround works in VISUAL
        mode = { "n", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "*",
        mode = "n",
        function()
          require("flash").jump({
            pattern = vim.fn.expand("<cword>"),
            jump = {
              -- add pattern to search history
              history = true,
              -- add pattern to search register
              register = true,
            },
          })
        end,
        desc = "Initialize flash with the word under the cursor",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash in / Search (enabled by default)",
      },
    },
    opts = {
      vscode = false,
      search = {
        mode = "search",
        -- needs to be set to false so df{, dt}, etc work
        incremental = false,
      },
      modes = {
        -- options used when flash is activated through
        char = {
          keys = { "f", "F", "t", "T", ";", "," },
        },
        -- a regular search with `/` or `?`
        search = {
          -- when `true`, flash will be activated during regular search by default.
          -- You can always toggle when searching with `require("flash").toggle()`
          enabled = true,
        },
      },
    },
  },
}
