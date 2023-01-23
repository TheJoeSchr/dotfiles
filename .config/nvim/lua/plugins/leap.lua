return {
  "ggandor/leap.nvim",
  config = function()
    vim.keymap.set("n", "<localleader>L", "<Plug>(leap-backward-to)", { desc = "Forward [L]eap" })
    vim.keymap.set("n", "<localleader>l", "<Plug>(leap-forward-to)", { desc = "Forward [l]eap" })
  end,
}
