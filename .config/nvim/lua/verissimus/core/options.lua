-- Define a custom color used for borders
BORDER = "#504945"

-- Disable GUI cursor styling (uses terminal default)
vim.opt.guicursor = ""

-- Enable 24-bit RGB colors in terminal
vim.opt.termguicolors = true

-- Show absolute line numbers
vim.opt.nu = true
-- Show relative line numbers (distance from current line)
vim.opt.relativenumber = true

-- Tab and indentation settings
vim.opt.tabstop = 4 -- Number of spaces a <Tab> displays
vim.opt.softtabstop = 4 -- Number of spaces a <Tab> inserts
vim.opt.shiftwidth = 4 -- Number of spaces for autoindent
vim.opt.expandtab = true -- Convert tabs to spaces

-- Enable intelligent auto-indentation
vim.opt.smartindent = true

-- Always show the sign column (prevents UI shift)
vim.opt.signcolumn = "yes"

-- Disable line wrapping (long lines will overflow)
vim.opt.wrap = false

-- Disable swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- Set directory for persistent undo files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true -- Enable persistent undo

-- Disable highlighting of search matches
vim.opt.hlsearch = false
-- Enable incremental search (shows results as you type)
vim.opt.incsearch = true

-- Enable 24-bit colors again (redundant, already set above)
vim.opt.termguicolors = true

-- Keep 8 lines visible above and below cursor when scrolling
vim.opt.scrolloff = 8

-- Allow "@" in file names
vim.opt.isfname:append("@-@")

-- Decrease update time (for faster diagnostics, CursorHold, etc.)
vim.opt.updatetime = 50

-- Hide mode text like -- INSERT -- (statusline plugins handle this)
vim.o.showmode = false

-- Define diagnostic signs using Japanese characters
local signs = {
	[vim.diagnostic.severity.ERROR] = "海",
	[vim.diagnostic.severity.WARN] = "愛",
	[vim.diagnostic.severity.HINT] = "お",
	[vim.diagnostic.severity.INFO] = "え",
}

vim.diagnostic.config({
	virtual_text = {
		prefix = function(diagnostic)
			return signs[diagnostic.severity] or "●"
		end,
	},
	underline = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs[vim.diagnostic.severity.ERROR],
			[vim.diagnostic.severity.WARN] = signs[vim.diagnostic.severity.WARN],
			[vim.diagnostic.severity.HINT] = signs[vim.diagnostic.severity.HINT],
			[vim.diagnostic.severity.INFO] = signs[vim.diagnostic.severity.INFO],
		},
	},
})

-- Set floating window border color
vim.api.nvim_set_hl(0, "FloatBorder", { fg = BORDER })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = BORDER })

