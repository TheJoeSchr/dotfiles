local function set_keymaps()
  -- vista
  vim.keymap.set("n", "<Leader>o", "<Leader>cs")
  local wk = require("which-key")
  -- dap
  wk.register({
    d = {
      name = "debugger",
      b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Set Breakpoint" },
      B = {
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        "Conditional Breakpoint",
      },
      s = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
      n = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
      o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
      u = { "<cmd>lua require('dap').up()<CR>", "Up" },
      d = { "<cmd>lua require('dap').down()<CR>", "Down" },
      q = { "<cmd>lua require('dap').terminate()<CR>", "Terminate" },
      l = { "<cmd>Lazy<CR>", "Lazy" },
    },
    -- D = {
    --   D = { "<cmd>lua require('dap').continue()<CR>", "Start/Continue" },
    -- },
    g = {
      l = {
        "<cmd>Lazy<CR>",
        "Lazy",
      },
    },
  }, {
    prefix = "<leader>",
  })
end
set_keymaps()
return {
  { "tpope/vim-rhubarb", cmd = "Gbrowse" },
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
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function(_, opts)
      require("zen-mode").setup({
        window = {
          backdrop = 0.95,
        },
      })
      return opts
    end,
    opts = {
      window = {
        width = 90,
        options = {
          number = true,
          relativenumber = true,
        },
      },
    },
    keys = {
      { "<leader>uF", ":ZenMode<CR>", desc = "ZenMode" },
    },
  },

  {
    "nyngwang/NeoZoom.lua",
    config = function()
      require("neo-zoom").setup({
        -- top_ratio = 0,
        -- left_ratio = 0.225,
        -- width_ratio = 0.775,
        -- height_ratio = 0.925,
        -- exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf' },
        -- disable_by_cursor = true, -- zoom-out/unfocus when you click anywhere else.
        -- popup = {
        --   -- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
        --   -- This way you won't see two windows of the same buffer
        --   -- got updated at the same time.
        --   enabled = true,
        --   exclude = {
        --     'dap-repl',
        --     'dapui_stacks',
        --     'dapui_watches',
        --     'dapui_scopes',
        --     'dapui_breakpoints',
        --     'dapui_console',
        --   }
        -- },
        exclude_buftypes = { "terminal" },
      })
      vim.keymap.set("n", "<leader>af", "<cmd>NeoZoomToggle<CR>", { silent = false, nowait = true })
      -- vim.keymap.set("n", "<CR>", function()
      --   vim.cmd("NeoZoomToggle")
      -- end, { silent = true, nowait = true })
    end,
  },
  {
    -- close other buffers (and more)
    "Asheq/close-buffers.vim",
    keys = {
      { "<leader>QQ", "<cmd>Bdelete other<CR>", desc = "Delete All Other Buffers" },
      { "<leader>ax", "<cmd>qa<cr>", desc = "Close All" },
      { "<leader>Q", "<cmd>Bdelete this<CR>", desc = "Delete This Buffers" },
      { "<leader>qq", "<cmd>Bdelete menu<CR>", desc = "Close Buffer menu" },
      { "Q", "<cmd>Bdelete menu<CR>", desc = "Close Buffer menu" },
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
    config = function()
      require("noice").setup({
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
      })
    end,
  },
  -- lsp symbol in statusline
  { "nvim-lua/lsp-status.nvim", lazy = false },
  {
    "stevearc/dressing.nvim",
    -- enabled = false,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      timeout = 500,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.55)
      end,
    },
  },
}
