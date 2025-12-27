return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				svelte = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				graphql = { "prettierd" },
				liquid = { "prettierd" },
				php = { "php-cs-fixer" },
				lua = { "stylua" },
				python = { "isort", "black" },
				bash = { "shfmt" },
				sh = { "shfmt" },
			},
			formatters = {
				eslint_d = {
					command = "eslint_d",
					args = { "--fix", "$FILENAME" },
					stdin = false,
					cwd = require("conform.util").root_file({ ".eslintrc.js", "eslint.config.js", ".git" }),
				},
				["php-cs-fixer"] = {
					command = "php-cs-fixer",
					args = {
						"fix",
						"--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
						"$FILENAME",
					},
					stdin = false,
				},
				prettierd = {
					command = "/home/verissimus/.local/share/nvim/mason/bin/prettierd",
					-- Global options for prettier --
					-- prepend_args = { "--use-tabs", "--single-quote", "--jsx-single-quote", "--bracket-same-line" },
				},
			},
			notify_on_error = true,
			notify_no_formatters = true,
			log_level = vim.log.levels.DEBUG,
		})

		vim.keymap.set("n", "<leader>f", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				-- timeout_ms = 2500,
				timeout_ms = 50000,
			})
		end)

		-- vim.keymap.set("n", "<leader>lf", function()
		-- 	require("conform").format({ formatters = { "eslint_d" } })
		-- end, { desc = "Run eslint_d --fix" })
	end,
}
