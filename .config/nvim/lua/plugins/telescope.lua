return {
  -- add telescope-fzf-native
  {
    "nvim-telescope/telescope.nvim",
    -- change some telescope options and a keymap to browse plugin files
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fH",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazyvim.util").get_root() })
        end,
        desc = "Find Files (Root)",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    dependencies = {
      { "nvim-telescope/telescope-dap.nvim", build = "make" },
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzf-writer.nvim",
      "nvim-telescope/telescope-github.nvim",
    },
    -- apply the config and additionally load fzf-native
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("dap")
      telescope.load_extension("fzf")
      telescope.load_extension("gh")
    end,
  },
}
