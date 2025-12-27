return {
	"windwp/nvim-ts-autotag",
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				filetypes = { "html", "xml", "typescriptreact" },
			},
		})
	end,
}
