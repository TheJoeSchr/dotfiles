return {
  {
    "ggandor/leap.nvim",
    enabled = false,
    config = function()
      vim.keymap.set("n", "<localleader>L", "<Plug>(leap-backward-to)", { desc = "Forward [L]eap" })
      vim.keymap.set("n", "<localleader>l", "<Plug>(leap-forward-to)", { desc = "Forward [l]eap" })
    end,
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup(opts)
    end,
  },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.animate", enabled = false },
  { "echasnovski/mini.move", enabled = false },
}
