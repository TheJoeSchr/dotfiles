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
      -- -- ChatGPT
      -- { "<leader>cg", "ggVG<cmd>lua require('chatgpt').edit_with_instructions()<CR>", desc = "ChatGPT" },
      -- Copy directy from LazyVim
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
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
      { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
      { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>ss",
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
        desc = "Goto Symbol",
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
