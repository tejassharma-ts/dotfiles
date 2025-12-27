return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = { char = "|", smart_indent_cap = true },
		})

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				vim.api.nvim_command(":IBLDisable")
			end,
		})
	end,
}
