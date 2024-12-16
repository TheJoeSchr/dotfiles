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
  { "flazz/vim-colorschemes" },
  { "sonph/onehalf", event = "VeryLazy" },
  { "morhetz/gruvbox", event = "VeryLazy" },
  { "catppuccin/nvim", name = "catppuccin", event = "VeryLazy" },
  { "sainnhe/sonokai", event = "VeryLazy" },
  { "sainnhe/edge", event = "VeryLazy" },
  { "sainnhe/everforest", event = "VeryLazy" },
  { "ericbn/vim-solarized", event = "VeryLazy" },

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
  -- smoothscroll
  {
    "folke/snacks.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      scroll = { enabled = false },
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
}
