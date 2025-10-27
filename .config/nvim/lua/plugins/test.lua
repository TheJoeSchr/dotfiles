return {
  -- RUBY
  { "volodya-lombrozo/neotest-ruby-minitest" },
  {
    "nvim-neotest/neotest",
    opts = { adapters = { "neotest-ruby-minitest" } },
    lazy = true,
    dependencies = {
      "volodya-lombrozo/neotest-ruby-minitest",
    },
  },
}
