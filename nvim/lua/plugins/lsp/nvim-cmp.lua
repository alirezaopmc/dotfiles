return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",

			-- For vsnip users.
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",

			-- For luasnip users.
			-- "L3MON4D3/LuaSnip",
			-- "saadparwaiz1/cmp_luasnip",

			-- For mini.snippets users.
			-- "echasnovski/mini.snippets",
			-- "abeldekat/cmp-mini-snippets",

			-- For ultisnips users.
			-- "SirVer/ultisnips",
			-- "quangnguyen30192/cmp-nvim-ultisnips",

			-- For snippy users.
			-- "dcampos/nvim-snippy",
			-- "dcampos/cmp-snippy",
	},
	config = function()
			local cmp = require("cmp")
			cmp.setup({
					snippet = {
							expand = function(args)
									vim.fn["vsnip#anonymous"](args.body)
							end,
					},
					window = {
							-- Uncomment these lines for bordered windows.
							-- completion = cmp.config.window.bordered(),
							-- documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert({
							["<C-b>"] = cmp.mapping.scroll_docs(-4),
							["<C-f>"] = cmp.mapping.scroll_docs(4),
							["<C-Space>"] = cmp.mapping.complete(),
							["<C-e>"] = cmp.mapping.abort(),
							["<CR>"] = cmp.mapping.confirm({ select = true }),
					}),
					sources = cmp.config.sources({
							{ name = "nvim_lsp" },
							{ name = "vsnip" },
					}, {
							{ name = "buffer" },
					}),
			})

			-- Use buffer source for '/' and '?' in command-line mode.
			cmp.setup.cmdline({ "/", "?" }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
							{ name = "buffer" },
					},
			})

			-- Use cmdline & path source for ':' in command-line mode.
			cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
							{ name = "path" }
					}, {
							{ name = "cmdline" }
					}),
					matching = { disallow_symbol_nonprefix_matching = false },
			})

			-- Set up lspconfig with nvim-cmp capabilities.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Replace <YOUR_LSP_SERVER> with each LSP server you've enabled.
			require("lspconfig")["<YOUR_LSP_SERVER>"].setup({
					capabilities = capabilities,
			})
	end,
}