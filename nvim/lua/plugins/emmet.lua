return {
	"mattn/emmet-vim",
	ft = {
		"html",
		"css",
		"liquid",
	},
	init = function()
		-- Use init for globals so they are set BEFORE the plugin loads
		vim.g.user_emmet_leader_key = "<C-e>"
	end,
	config = function()
		vim.g.user_emmet_settings = {
			liquid = {
				extends = "html",
			},
		}
	end,
}
