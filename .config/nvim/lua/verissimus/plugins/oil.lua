return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = {
						"actions.select",
						opts = { vertical = true },
						desc = "Open the entry in a vertical split",
					},
					["<C-h>"] = { "actions.select", opts = { vertical = true } },
					["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
					["ye"] = {
						desc = "Copy filepath to system clipboard",
						callback = function()
							require("oil.actions").copy_entry_path.callback()
							vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
						end,
					},
				},
				keymaps_help = {
					border = "single",
				},
			})
		end,
	},
}
