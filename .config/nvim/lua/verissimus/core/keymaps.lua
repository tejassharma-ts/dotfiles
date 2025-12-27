-- Set <Space> as the leader key
vim.g.mapleader = " "

-- Move selected lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move selection up

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z") -- Join lines but return cursor to its original position

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Scroll down half-page and center
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Scroll up half-page and center

-- Keep search terms centered when navigating through results
vim.keymap.set("n", "n", "nzzzv") -- Next match
vim.keymap.set("n", "N", "Nzzzv") -- Previous match

-- Paste over selection without overwriting the unnamed register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without affecting registers
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Replace `:Ex` (netrw) with Oil.nvim file explorer
vim.keymap.set("n", "<leader>e", function()
	require("oil").open()
end)

-- Disable accidental use of Q (often enters Ex mode)
vim.keymap.set("n", "Q", "<nop>")

-- Open a tmux sessionizer script in a new tmux window
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Quickfix navigation
vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz") -- Next item in quickfix list
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz") -- Previous item in quickfix list

-- Alternate mappings (commented): for location list instead of quickfix
-- vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- Replace word under cursor throughout the file with confirmation
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable (useful for scripts)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Scroll 20 characters to the right and left
vim.api.nvim_set_keymap("n", "<S-L>", "20zl", { noremap = true, silent = true }) -- Shift+L: scroll right
vim.api.nvim_set_keymap("n", "<S-H>", "20zh", { noremap = true, silent = true }) -- Shift+H: scroll left

-- Stay in visual mode when indenting
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true }) -- indent left
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true }) -- indent right

-- Toggle indentation guides with IBL (Indent Blankline)
vim.keymap.set("n", "<leader>i", ":IBLToggle<cr>", { silent = true })

-- Count total matches of last search pattern
vim.api.nvim_set_keymap("n", "<leader>c<cr>", [[:%s///gn<CR>]], { noremap = true, silent = true })

-- Diagnostic key mappings
vim.api.nvim_set_keymap(
	"n",
	"<leader>do",
	"<cmd>lua vim.diagnostic.open_float()<CR>",
	{ noremap = true, silent = true }
) -- Open diagnostic popup
vim.api.nvim_set_keymap("n", "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true }) -- Previous diagnostic
vim.api.nvim_set_keymap("n", "<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true }) -- Next diagnostic

-- Highlight on yank (copy)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Print current buffer location
vim.keymap.set("n", "<leader>pp", function()
	print(vim.api.nvim_buf_get_name(0))
end, { desc = "Print full path of current buffer" })

vim.keymap.set("n", "<leader>lf", function()
	local currentFilePath = vim.api.nvim_buf_get_name(0)
	vim.cmd("! eslint_d --fix --quiet " .. currentFilePath)
	-- print(currentFilePath);
end, { desc = "" })

vim.api.nvim_create_user_command("QuickfixStaged", function()
	local files = vim.fn.systemlist("git diff --name-only")
	local qf_list = {}
	for _, file in ipairs(files) do
		table.insert(qf_list, { filename = file, lnum = 1, col = 1, text = file })
	end
	vim.fn.setqflist(qf_list, "r")
	vim.cmd("copen")
end, {})

-- quickfix list delete keymap
function Remove_qf_item()
	local curqfidx = vim.fn.line(".")
	local qfall = vim.fn.getqflist()

	-- Return if there are no items to remove
	if #qfall == 0 then
		return
	end

	-- Remove the item from the quickfix list
	table.remove(qfall, curqfidx)
	vim.fn.setqflist(qfall, "r")

	-- Reopen quickfix window to refresh the list
	vim.cmd("copen")

	-- If not at the end of the list, stay at the same index, otherwise, go one up.
	local new_idx = curqfidx < #qfall and curqfidx or math.max(curqfidx - 1, 1)

	-- Set the cursor position directly in the quickfix window
	local winid = vim.fn.win_getid() -- Get the window ID of the quickfix window
	vim.api.nvim_win_set_cursor(winid, { new_idx, 0 })
end

vim.cmd("command! RemoveQFItem lua Remove_qf_item()")
vim.api.nvim_command("autocmd FileType qf nnoremap <buffer> dd :RemoveQFItem<cr>")
