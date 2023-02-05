local Util = require("lazyvim.util")
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
      { "<leader>'", "<cmd>Telescope marks<CR>", desc = "Jump to [M]ark" },
      { "<leader>sc", "<cmd>Telescope commands<CR>", desc = "[S]earch [c]ommands" },
      { "<leader>sC", "<cmd>Telescope command_history<CR>", desc = "[S]earch [C]ommands" },
      { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "[S]earch [K]eymaps" },
      -- remap alias <leader>s to <leader>f
      { "<leader>fa", "<leader>sa", desc = "Auto Commands", remap = true },
      { "<leader>fB", "<leader>sb", desc = "Buffer", remap = true },
      { "<leader>fc", "<leader>sc", desc = "Command History", remap = true },
      { "<leader>fC", "<leader>sC", desc = "Commands", remap = true },
      { "<leader>fd", "<leader>sd", desc = "Diagnostics", remap = true },
      { "<leader>fg", "<leader>sg", desc = "Grep (root dir)", remap = true },
      { "<leader>fG", "<leader>sG", desc = "Grep (cwd)", remap = true },
      { "<leader>fh", "<leader>sh", desc = "Help Pages", remap = true },
      { "<leader>fH", "<leader>sH", desc = "Search Highlight Groups", remap = true },
      { "<leader>fk", "<leader>sk", desc = "Key Maps", remap = true },
      { "<leader>fM", "<leader>sM", desc = "Man Pages", remap = true },
      { "<leader>fm", "<leader>sm", desc = "Jump to Mark", remap = true },
      { "<leader>fo", "<leader>so", desc = "Options", remap = true },
      { "<leader>fw", "<leader>sw", desc = "Word (root dir)", remap = true },
      { "<leader>fW", "<leader>sW", desc = "Word (cwd)", remap = true },
      { "<leader>fs", builtin.current_buffer_fuzzy_find, desc = "Search (in current buffer)", remap = true },
      { "<leader>fS", "<leader>ss", desc = "Goto Symbol", remap = true },
      -- add a keymap to browse plugin files
      {
        "<leader>fH",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      -- Copy directy from LazyVim
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<C-p>", "<leader>ff", desc = "Fuzzy Finder", remap = true },
      -- find
      { "<leader>fb", builtin.buffers, desc = "[B]uffers" },
      { "<leader>ff", Util.telescope("files"), desc = "Find [f]iles (root dir)" },
      { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "[F]ind [F]iles (cwd)" },
      { "<leader>fr", builtin.resume, desc = "[R]resume" },

      { "<leader>fq", Util.telescope("quickfixhistory"), desc = "[Q]uickFixHistory" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gC", "<cmd>Telescope git_bcommits<CR>", desc = "file commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>te", "<cmd>Telescope file_browser<CR>", desc = "Telescope File Browser" },
      { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
      { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>cts",
        Util.telescope("lsp_document_symbols", {
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
        Util.telescope("lsp_references", {
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
