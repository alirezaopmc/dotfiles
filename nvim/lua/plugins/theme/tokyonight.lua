return {
	"folke/tokyonight.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		-- Detect macOS appearance using AppleScript
		local function is_dark_mode()
			local handle = io.popen(
				[[osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode']]
			)
			if handle then
				local result = handle:read("*a")
				handle:close()
				return result:match("true") ~= nil
			end
			return true -- default to dark if detection fails
		end

		local style = is_dark_mode() and "night" or "day"

		require("tokyonight").setup({
			style = style,
			styles = {
				comments = { italic = false },
			},
		})

		vim.cmd.colorscheme("tokyonight")

		vim.api.nvim_create_user_command("ToggleTheme", function()
			local current = vim.g.colors_name or ""
			local next = current:match("tokyonight%-day") and "tokyonight-night" or "tokyonight-day"
			vim.cmd.colorscheme(next)
			vim.notify("Switched to " .. next)
		end, {})

		vim.keymap.set("n", "<leader>ut", "<cmd>ToggleTheme<CR>", { desc = "Toggle Theme" })
	end,
}
