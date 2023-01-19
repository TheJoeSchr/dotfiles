return {
  "ggandor/leap.nvim",
  config = function()
    vim.keymap.set("n", "<leader>L", "<Plug>(leap-backward-to)", { desc = "Forward [L]eap" })
    vim.keymap.set("n", "<leader>l", "<Plug>(leap-forward-to)", { desc = "Forward [l]eap" })
  end,
}
