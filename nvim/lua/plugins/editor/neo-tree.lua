toggleNeoTree = function()
	local neo_win = nil
	local neo_open = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.api.nvim_buf_get_option(buf, "filetype")
		if ft == "neo-tree" then
			neo_open = true
			neo_win = win
			break
		end
	end
	if not neo_open then
		vim.cmd("Neotree show")
	else
		if vim.api.nvim_get_current_win() == neo_win then
			vim.cmd("Neotree close")
		else
			vim.api.nvim_set_current_win(neo_win)
		end
	end
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {'3rd/image.nvim', opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false, -- neo-tree will lazily load itself
	keys = {
		{ "\\", "<cmd>lua toggleNeoTree()<CR>", desc = "NeoTree reveal", silent = true },
	},
	---@module 'neo-tree'
	---@type neotree.Config?
	opts = {
		filesystem = {
			filtered_items = {
				visible = ture,
				hide_dotfiles = false,
			},
		},
	},
}
