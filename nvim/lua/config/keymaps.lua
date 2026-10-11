local telescope = require("telescope.builtin")

-- telescope
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fF", function() telescope.find_files({ hidden = false, no_ignore = true }) end, { desc = "Telescope find files (no hidden, no ignore)" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fw", telescope.grep_string, { desc = "Telescope grep string" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })

-- general
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "Yank line to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selected to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste line to system clipboard" })

vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>_", "<cmd>split<cr>", { desc = "Horizontal Split" })

vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "Create new buffer" })

vim.keymap.set("n", "n", "nzz", { desc = "Go next and center" })
vim.keymap.set("n", "N", "Nzz", { desc = "Go previous and center" })

-- Navigation and Centering
vim.keymap.set("n", "J", "jzz", { desc = "Move down one line and center" })
vim.keymap.set("n", "K", "kzz", { desc = "Move up one line and center" })

-- Remap 'K' to show documentation (default hover behavior) OR diagnostics
local smart_k = function()
	-- Use a pcall to safely check if the diagnostic function is available and returns errors
	local ok, diagnostics =
		pcall(vim.diagnostic.get_line_diagnostics, 0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })

	-- Fallback logic for older Neovim versions where `vim.diagnostic.get_line_diagnostics` is nil
	if not ok or diagnostics == nil or #diagnostics == 0 then
		-- No diagnostics, perform LSP hover
		vim.lsp.buf.hover()
	else
		-- Diagnostics are present, open the diagnostic float
		vim.diagnostic.open_float({ border = "rounded" })
	end
end

vim.keymap.set("n", "K", smart_k, { desc = "LSP Hover / Diagnostic Float" })

--HARPOON
local harpoon = require("harpoon")
harpoon:setup({})

vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end, { desc = "Harpoon Add" })
vim.keymap.set("n", "<leader>hh", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>h[", function()
	harpoon:list():prev()
end, { desc = "Prev Harpoon file" })
vim.keymap.set("n", "<leader>h]", function()
	harpoon:list():next()
end, { desc = "Next Harpoon file" })

vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end)

vim.keymap.set("n", "<leader>hr", function()
	harpoon:list():remove()
end, { desc = "Remove file from Harpoon" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
