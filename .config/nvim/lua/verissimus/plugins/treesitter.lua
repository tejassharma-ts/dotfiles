return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
			},

			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			-- enable indentation
			indent = {
				enable = true,
				disable = { "html", "c" },
			},
		})
	end,
}
