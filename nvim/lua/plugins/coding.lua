return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
		},
		event = "VeryLazy",
		config = function()
			-- 1. Enable Typescript (Renamed from tsserver to ts_ls)
			vim.lsp.enable("ts_ls")

			-- 2. Enable Rust
			vim.lsp.enable("rust_analyzer")

			-- Example: Configuring settings before enabling
			-- vim.lsp.config("lua_ls", {
			--   settings = { Lua = { diagnostics = { globals = { "vim" } } } }
			-- })
			-- vim.lsp.enable("lua_ls")
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{

		"stevearc/conform.nvim",
		opts = {
			format_on_save = true,
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "prettier", "eslint_d" },
				javascript = { "prettier", "eslint_d" },
				json = { "prettier" },
				markdown = { "prettier" },
				-- Liquid files with prettier
				liquid = { "prettier" },
				javascriptreact = { "prettier", "eslint_d" },
				typescriptreact = { "prettier", "eslint_d" },
				css = { "prettier" },
				scss = { "prettier" },
			},
			formatters = {
				prettier = {
					command = "prettier",
					args = { "--stdin-filepath", "$FILENAME" },
				},
			},
		},
	},
	{
		"dense-analysis/ale",
		-- ALE uses global variables for configuration, which we set in the config function
		init = function()
			-- Linter Configuration: Use eslint_d for JS/TS filetypes
			vim.g.ale_linters = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				vue = { "eslint_d" },
			}

			-- Fixer Configuration: Use eslint_d (and optionally prettier) for fixing
			-- Note: Conform is generally better for fixing, but this is how ALE does it
			vim.g.ale_fixers = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
			}

			-- Enable fixing on save (Optional, you may prefer Conform for this)
			-- vim.g.ale_fix_on_save = true

			-- General Behavior Settings:
			-- Disable signs in the gutter (often prettier with LSP signs)
			-- vim.g.ale_set_signs = false

			-- Set up sign colors/text (optional)
			vim.cmd([[
                let g:ale_sign_error = ''
                let g:ale_sign_warning = ''
            ]])
		end,
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default" },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {
			builtin_marks = { ".", "<", ">", "^" },
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "BufReadPost",
		init = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using 99 to disable limits - let ufo manage folds
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		},
	},
	{
		"leath-dub/snipe.nvim",
		keys = {
			{
				"gb",
				function()
					require("snipe").open_buffer_menu()
				end,
				desc = "Open Snipe buffer menu",
			},
		},
		opts = {},
	},
	{
		"olimorris/codecompanion.nvim",
		version = "^19.0.0",
		opts = {
			strategies = {
				chat = {
					adapter = "opencode",
					model = "opencode-go",
				},
				inline = {
					adapter = "opencode",
				},
			},
			adapters = {
				opencode = function()
					return require("codecompanion.adapters").extend("openai", {
						env = {
							api_key = "cmd:echo $OPENCODE_API_KEY",
						},
						url = "https://opencode.ai/zen/v1/chat/completions",
						schema = {
							model = {
								default = "opencode-go",
							},
						},
					})
				end,
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
