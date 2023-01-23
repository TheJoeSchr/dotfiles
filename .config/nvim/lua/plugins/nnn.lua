return {
  -- file explorer
  {
    "luukvbaal/nnn.nvim",
    enabled = true,
    cmd = "nnn -a",
    keys = {
      {
        "<leader>fp",
        function()
          require("nnn").toggle("picker", require("lazyvim.util").get_root())
        end,
        desc = "Picker NNN (root dir)",
      },
      { "<leader>fP", "<cmd>NnnExplorer<CR>", desc = "Explorer" },
    },
    config = function()
      require("nnn").setup()
    end,
    -- init = function()
    --   if vim.fn.argc() == 1 then
    --     local stat = vim.loop.fs_stat(vim.fn.argv(0))
    --     if stat and stat.type == "directory" then
    --       require("nnn")
    --     end
    --   end
    -- end,
  },
}
