if true then
	return {}
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		-- custom border
		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { height = 0.99, width = 0.99 },
				prompt_prefix = "❯ ",
				selection_caret = "❯ ",
				file_ignore_patterns = {
					"node_modules/.*",
				},
				borderchars = {
					"─",
					"│",
					"─",
					"│",
					"┌",
					"┐",
					"┘",
					"└",
				},
				-- clear prompt
				mappings = {
					i = {
						-- ["<C-u>"] = false,
					},
				},
			},
			pickers = {
				buffers = {
					mappings = {
						i = {
							-- deleting buffer
							["<c-d>"] = actions.delete_buffer + actions.move_to_top,
						},
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})

		-- show hidden file also
		vim.keymap.set("n", "<leader>phf", function()
			builtin.find_files({
				hidden = true,
			})
		end, { desc = "show hidden files" })

		vim.keymap.set("n", "<leader>pht", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>ts", builtin.spell_suggest, {})
	end,
}
