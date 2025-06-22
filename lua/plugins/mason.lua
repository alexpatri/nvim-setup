-- lua/plugins/mason.lua (ou onde você o tiver)

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- Configura o Mason primeiro
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Em seguida, configura o mason-lspconfig
		-- Esta seção garante que os servidores de linguagem listados sejam instalados pelo Mason.
		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"gopls",
				"lua_ls",
				"cssls",
				"emmet_ls", -- Adicionado para corresponder ao seu lsp-config
				"html", -- Adicionado para corresponder ao seu lsp-config
			},
			-- automatic_installation = true -- Esta opção pode ser útil
		})

		-- Finalmente, configura o mason-tool-installer
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
