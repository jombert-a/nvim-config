local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

mason.setup()
mason_lspconfig.setup {
	ensure_installed = { 'lua_ls' },
}

-- After setting up mason-lspconfig you may set up servers via lspconfig
lspconfig.lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},

			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
				}
			},
		},
	},
	on_attach = function(client, bufnr)
		-- Only set up formatting on save if the server supports it
		if client.server_capabilities.documentFormattingProvider then
			-- Create an auto command that triggers formatting on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.lua",
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,

}
