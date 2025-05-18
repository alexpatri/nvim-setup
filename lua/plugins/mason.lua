return {
	"williamboman/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		require("mason").setup({

			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"gopls",
				"lua_ls",
				"cssls",
				"volar",
			},
			automatic_installation = true,
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"clang-format",
				"golines",
				"prettier",
				"stylua",
				"ts-standard",
				"shfmt",
			},
		})
	end,
}
