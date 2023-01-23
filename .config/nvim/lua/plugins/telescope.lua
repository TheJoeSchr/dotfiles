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
      -- " Using lua functions
      -- nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
      -- " file finder
      -- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
      --
      -- " grep in current buffer
      -- nnoremap <leader>fs <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
      -- " grep all files in workdir
      -- nnoremap <leader>fa <cmd>lua require('telescope.builtin').live_grep()<cr>
      -- " rg | fzf
      -- nnoremap <leader>fA :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
      -- nnoremap <leader>faw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
      -- " search in current buffer
      -- nnoremap <leader>fs <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
      -- " find word under cursor
      --
      -- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
      -- nnoremap <Leader>' <cmd>lua require('telescope.builtin').marks()<cr>
      -- nnoremap <leader>; <cmd>lua require('telescope.builtin').oldfiles()<cr>
      -- nnoremap <Leader>fg <cmd>lua require('telescope.builtin').git_commits()<cr>
      -- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
      -- nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
      -- nnoremap <leader>ft <cmd>lua require('telescope.builtin').tags()<cr>
      -- nnoremap <leader>fk <cmd>lua require('telescope.builtin').keymaps()<cr>
      -- nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfixhistory()<cr>
      -- " ---------------- /Telescope --------
      -- nnoremap <leader>f: <cmd>lua require('telescope.builtin').commands_history()<cr>
      { "<leader>;", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files" },
      { "<leader>'", "<cmd>Telescope marks<CR>", desc = "Jump to [M]ark" },
      { "<leader>sc", "<cmd>Telescope commands<CR>", desc = "Recent Files" },
      { "<leader>sC", "<cmd>Telescope command_history<CR>", desc = "Recent Files" },
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
      { "<leader>fs", "<leader>ss", desc = "Goto Symbol", remap = true },
      -- add a keymap to browse plugin files
      {
        "<leader>fH",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      -- ChatGPT
      { "<leader>cg", "ggVG<cmd>lua require('chatgpt').edit_with_instructions()<CR>", desc = "ChatGPT" },
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
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzf-writer.nvim",
      "nvim-telescope/telescope-github.nvim",
      "tsakirist/telescope-lazy.nvim",
    },
    -- apply the config and additionally load fzf-native
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("dap")
      telescope.load_extension("gh")
      return opts
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    -- apply the config and additionally load fzf-native
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      return opts
    end,
  },
}
      -- stylua: ignore
