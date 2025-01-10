local function set_keymaps()
  vim.keymap.set("n", "<leader>uo", function()
    vim.cmd([[hi Normal guibg=None ctermbg=None]]) -- maybe can use `vim.api.nvim_set_hl` instead
    vim.cmd([[hi NonText ctermbg=NONE]])
  end, { desc = "set background nil" })
  vim.keymap.set("n", "<Leader>ut", "<cmd>Twilight<CR>", { desc = "Twilight off/on" })
end

set_keymaps()

return {
  -- themes
  { "MarcoKorinth/onehalf.nvim", lazy = false, priority = 1000 },
  { "morhetz/gruvbox", event = "VeryLazy" },
  { "catppuccin/nvim", name = "catppuccin", event = "VeryLazy" },
  { "sainnhe/sonokai", event = "VeryLazy" },
  { "sainnhe/edge", event = "VeryLazy" },
  { "sainnhe/everforest", event = "VeryLazy" },
  { "navarasu/onedark.nvim", lazy = false, priority = 1000 },
  { "ericbn/vim-solarized", event = "VeryLazy" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "storm", -- The theme is used when the background is set to light
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
    },
  },
  { "slugbyte/lackluster.nvim", lazy = false, priority = 1000 },

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
    "folke/snacks.nvim",
    opts = {
      -- smoothscroll
      scroll = { enabled = false },
      indent = {
        enabled = false, -- enable indent guides
        char = "│",
        only_scope = true, -- only show indent guides of the scope
        only_current = true, -- only show indent guides in the current window
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = true,
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = ">",
        },
      },
    },
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
      { "<C-w>;", "<cmd>NeoZoomToggle<CR>", desc = "NeoZoomToggle" },
    },
  },
  -- lsp symbol in statusline
  { "nvim-lua/lsp-status.nvim", lazy = false },
  { "lukas-reineke/indent-blankline.nvim", opts = {
    enabled = false,
  } },
}
