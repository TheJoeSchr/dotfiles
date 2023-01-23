return {
  "folke/zen-mode.nvim",
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
    { "n", "<leader>zz", ":ZenMode<CR>" },
  },
}
