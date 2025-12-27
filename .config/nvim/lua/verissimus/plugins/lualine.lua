return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local colors = {
				blue = "#80a0ff",
				cyan = "#79dac8",
				black = "#080808",
				white = "#000000",
				red = "#ff5189",
				violet = "#d183e8",
				grey = "#000000",
			}

			local bubbles_theme = {
				normal = {
					a = { fg = "#d4b398", bg = "#32302f", gui = "bold" },
					b = { fg = "#d4b398", bg = "#32302f " },
					c = { fg = colors.white },
				},
				insert = {
					a = { fg = "#d4b398", bg = "#32302f", gui = "bold" },
				},
				visual = {
					a = { fg = "#d4b398", bg = "#32302f", gui = "bold" },
				},
				replace = {
					a = { fg = "#d4b398", bg = "#32302f", gui = "bold" },
				},

				inactive = {
					a = { fg = "#e0def4", bg = "#31748f" },
					b = { fg = "#e0def4", bg = "#1f1d2e" },
					c = { fg = colors.white },
				},
			}

			require("lualine").setup({
				options = {
					theme = bubbles_theme,
					component_separators = "",
					section_separators = { left = "", right = " " },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							icons_enabled = true,
							icon = "",
							separator = { left = " ", right = "" },
							right_padding = 0,
							bold = "true",
						},
					},
					lualine_b = { "branch" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "filename" },
					lualine_z = {
						{ "progress", separator = { right = "", left = " " }, left_padding = 0 },
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})

      -- https://github.com/nvim-lualine/lualine.nvim/issues/1411
			local base_statusline_highlights =
				{ "StatusLine", "StatusLineNC", "Tabline", "TabLineFill", "TabLineSel", "Winbar", "WinbarNC" }
			for _, hl_group in pairs(base_statusline_highlights) do
				vim.api.nvim_set_hl(0, hl_group, { bg = "none" })
			end
		end,
	},
}
