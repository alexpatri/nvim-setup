-- lua/plugins/lsp/lsp-config.lua

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Autocmd e outras configurações permanecem as mesmas...
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Seu callback de keymaps aqui...
                local opts = { buffer = ev.buf, silent = true }
				-- ...
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

        -- CORRIGIDO: Voltamos a usar 'setup' e passamos a tabela 'handlers'
		mason_lspconfig.setup({
			handlers = {
				-- Handler padrão
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Handler customizado e moderno para o Volar
				["volar"] = function()
					local ts_path
					pcall(function()
						ts_path = require("mason-registry").get_package("typescript-language-server"):get_install_path()
							.. "/node_modules/typescript/lib"
					end)

					lspconfig.volar.setup({
						capabilities = capabilities,
						init_options = {
							typescript = {
								tsdk = ts_path,
							},
						},
					})
				end,

				-- Seus outros handlers customizados...
				["emmet_ls"] = function()
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html", "templ", "typescriptreact", "javascriptreact",
							"css", "sass", "scss", "less", "svelte",
						},
					})
				end,

				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
								completion = { callSnippet = "Replace" },
							},
						},
					})
				end,
			},
		})
	end,
}
