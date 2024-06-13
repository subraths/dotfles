return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd.colorscheme("tokyonight-storm")
		end,
	},
}
