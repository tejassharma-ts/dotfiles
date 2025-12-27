return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			keymap = {
				fzf = {
					true,
					["ctrl-q"] = "select-all+accept",
				},
			},
			winopts = {
				height = 0.95,
				width = 0.95,
				row = 0.50,
				col = 0.50,
				border = "single",
				title = "Title",
				title_pos = "center", -- 'left', 'center' or 'right'
				title_flags = false, -- uncomment to disable title flags
				preview = {
					border = "single", -- preview border: accepts both `nvim_open_win`
					title = true, -- preview border title (file/buf)?
					title_pos = "center", -- left|center|right, title alignment
					scrollbar = false,
				},
			},
			fzf_opts = { ["--layout"] = "default" },
		})

		vim.keymap.set("n", "<leader>pf", function()
			fzf.files({ cwd_prompt = false, prompt = "❯ " })
		end, {})
		vim.keymap.set("n", "<leader>ps", function()
			fzf.live_grep({ cwd_prompt = false, prompt = "❯ " })
		end, {})
		-- vim.keymap.set("n", "<leader>ej", fzf.jumps, { desc = "[telescope] show jumplist" })
	end,
	opts = {},
}
