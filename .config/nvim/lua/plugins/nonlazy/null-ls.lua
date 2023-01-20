local M = {}

local null_ls = require("null-ls")
local lsp_config = require("configs.plugins.lsp")

function M.setup()
	local code_actions = null_ls.builtins.code_actions
	local diagnostics = null_ls.builtins.diagnostics
	local formatting = null_ls.builtins.formatting
	null_ls.setup({
		sources = {
			code_actions.eslint_d,
			code_actions.gitsigns,
			diagnostics.codespell,
			diagnostics.eslint_d,
			diagnostics.flake8,
			diagnostics.mypy,
			diagnostics.shellcheck,
			formatting.black,
			formatting.fish_indent,
			formatting.isort,
			formatting.prettierd,
			formatting.stylua,
			formatting.terraform_fmt,
			formatting.trim_newlines,
			formatting.trim_whitespace,
		},
		on_attach = lsp_config.on_attach_no_symbols,
	})
end

return M
