local function set_keymaps()
  -- vista
  vim.keymap.set("n", "<Leader>o", function()
    vim.cmd([[hi Normal guibg=None ctermbg=None]]) -- maybe can use `vim.api.nvim_set_hl` instead
    vim.cmd([[hi NonText ctermbg=NONE]])
  end, { desc = "set background nil" })
  vim.keymap.set("n", "<Leader>ut", "<cmd>Twilight<CR>", { desc = "Twilight off/on" })
end

set_keymaps()

return {
  -- themes
  { "flazz/vim-colorschemes" },
  { "sonph/onehalf", event = "VeryLazy" },
  { "morhetz/gruvbox", event = "VeryLazy" },
  { "catppuccin/nvim", name = "catppuccin", event = "VeryLazy" },
  { "sainnhe/sonokai", event = "VeryLazy" },
  { "sainnhe/edge", event = "VeryLazy" },
  { "sainnhe/everforest", event = "VeryLazy" },
  { "ericbn/vim-solarized", event = "VeryLazy" },

  -- ui
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<leader>co", "<cmd>AerialToggle<cr>", desc = "Symbols [O]utline" },
      { "<leader>cO", "<cmd>AerialToggle!<cr>", desc = "Symbols [O]utline same Window" },
    },
  },
  -- breadcrumbs
  {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = true,
    event = "VeryLazy",
  },

  { "tpope/vim-rhubarb", cmd = "Gbrowse", event = "VeryLazy" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup({
        auto_open = false,
        auto_close = true,
        auto_preview = false,
        auto_fold = true,
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠",
        },
        use_lsp_diagnostic_signs = true,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
        highlight = {
          before = "",
          keyword = "wide",
          after = "fg",
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          pattern = [[\b(KEYWORDS):]],
          ignore_case = true,
          hidden = true,
          follow = true,
          auto_open = false,
          use_lsp_diagnostic = true,
          open_cmd = "edit",
        },
      })
    end,
  },
  {
    "nyngwang/NeoZoom.lua",
    config = function()
      require("neo-zoom").setup({
        winopts = {
          offset = {
            top = 0.00,
            left = 0.30,
            width = 0.70,
            height = 1,
          },
        },
        exclude_filetypes = { "lspinfo", "mason", "lazy", "fzf", "qf" },
        disable_by_cursor = true, -- zoom-out/unfocus when you click anywhere else.
        popup = {
          -- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
          -- This way you won't see two windows of the same buffer got updated at the same time.
          enabled = true,
          exclude = {
            "dap-repl",
            "dapui_stacks",
            "dapui_watches",
            "dapui_scopes",
            "dapui_breakpoints",
            "dapui_console",
          },
        },
        exclude_buftypes = { "terminal" },
      })
    end,
    keys = {
      { "<leader>af", "<cmd>NeoZoomToggle<CR>", desc = "NeoZoomToggle" },
      { "<C-w>o", "<cmd>NeoZoomToggle<CR>", desc = "NeoZoomToggle" },
      { ";", "<cmd>NeoZoomToggle<CR>", desc = "NeoZoomToggle" },
    },
  },
  {
    -- close other buffers (and more)
    -- " nnoremap <silent> Q     :close<CR>
    -- nnoremap <silent> Q     :Bdelete menu<CR>
    -- nnoremap <silent> <C-q> :Bdelete menu<CR>
    -- nnoremap <silent> <leader>Q     :Bdelete other<CR>
    -- nnoremap <silent> <leader>q :Bdelete menu<CR>
    "Asheq/close-buffers.vim",
    event = "BufRead",
    keys = {
      { "<leader>QQ", "<cmd>Bdelete other<CR>", desc = "Delete All Other Buffers" },
      { "<leader>ax", "<cmd>qa<cr>", desc = "Close All" },
      { "<leader>Q", "<cmd>bd<CR>", desc = "Delete This Buffers" },
      { "<leader>qq", "<cmd>Bdelete menu<CR>", desc = "Close Buffer menu" },
      { "Q", "<cmd>close<CR>", desc = "Close Buffer menu" },
      -- original V-block
      { "<C-Q>", "<C-w>q", desc = "Quick Close Window", { remap = true, nowait = true } },
      -- vim.keymap.set("n", "Q", "<cmd>bd<CR>")
      -- nnoremap <silent> Q     :Bdelete menu<CR>
    },
  },
  {
    "folke/noice.nvim",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    config = function(_, opts)
      require("noice").setup(vim.list_extend(opts, {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }))
      return opts
    end,
  },
  -- lsp symbol in statusline
  { "nvim-lua/lsp-status.nvim", lazy = false },
  { "stevearc/dressing.nvim" },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      timeout = 1000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.55)
      end,
    },
  },
}
