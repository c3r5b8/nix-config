return {
	{
		"f-person/auto-dark-mode.nvim",
		opts = {},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("catppuccin").setup({
				flavour = "latte",
				background = {
					light = "latte",
					dark = "mocha",
				},
			})

			vim.cmd.colorscheme("catppuccin-latte")
		end,
	},
}
