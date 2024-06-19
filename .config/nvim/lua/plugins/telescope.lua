vim.g.lazyvim_picker = "telescope"

local telescope = LazyVim.pick
local builtin = require("telescope.builtin")
return {
  -- add telescope-fzf-native
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    -- change some telescope options and a keymap to browse plugin files
    keys = {
      -- " === Telescope shorcuts === "
      -- "   <ctrl>p - Browse list of buffers & files in current directory/project
      -- "   <leader>: - Search command history
      -- "   <leader>; - Search for open buffers
      -- "   <leader>fg - Search current directory (rg)
      -- "   <leader>fw - Search current directory for occurences of word under cursor
      { "<leader>fg", "<leader>sg", desc = "Grep (root dir)", remap = true },
      { "<leader>fG", "<leader>sG", desc = "Grep (cwd)", remap = true },
      { "<C-p>", "<leader>ff", desc = "Fuzzy Finder", remap = true },
      { "<leader>'", "<cmd>Telescope marks<CR>", desc = "Jump to [M]ark" },
      { "<leader>fs", builtin.current_buffer_fuzzy_find, desc = "Search (in current buffer)", remap = true },
      -- add a keymap to browse plugin files
      {
        "<leader>fH",
        function()
          builtin.find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>cts",
        telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "[T]elescope [S]ymbol",
      },
      {
        "<leader>ctr",
        telescope("lsp_references", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "[T]elescope [R]eferences",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "flex",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    dependencies = {
      { "nvim-telescope/telescope-dap.nvim" },
      { "nvim-telescope/telescope-symbols.nvim" },
      { "nvim-telescope/telescope-fzf-writer.nvim" },
      { "nvim-telescope/telescope-github.nvim" },
      -- :Telescope lazy
      -- <C-o>	Open selected plugin repository in browser
      -- <M-b>	Open selected plugin with file-browser
      -- <C-f>	Open selected plugin with find files
      -- <C-g>	Open selected plugin with live grep
      -- <C-b>	Open lazy plugins picker, works only after having called first another action
      -- <C-r>f	Open lazy root with find files
      -- <C-r>g	Open lazy root with live grep
      { "tsakirist/telescope-lazy.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    -- apply the config and additionally load fzf-native
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("dap")
      telescope.load_extension("gh")
      telescope.load_extension("file_browser")
      telescope.load_extension("lazy")
      return opts
    end,
  },
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
        },
      })
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Telescope Undo" })
    end,
  },
  {
    "nvim-telescope/telescope-github.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
      vim.keymap.set("n", "<leader>;", "<cmd>Telescope frecency<cr>", { desc = "Recent Files" })
    end,
    keys = { "<leader>;" },
    dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
  },
}
-- stylua: ignore
