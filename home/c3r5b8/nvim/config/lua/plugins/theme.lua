return {
	{
		"Mofiqul/adwaita.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme adwaita")
		end,
	},
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		---@diagnostic disable-next-line: missing-fields
	-- 		require("catppuccin").setup({
	-- 			flavour = "latte",
	-- 			background = {
	-- 				light = "latte",
	-- 				dark = "mocha",
	-- 			},
	-- 		})
	--
	-- 		vim.cmd.colorscheme("catppuccin-latte")
	-- 	end,
	-- },
}
