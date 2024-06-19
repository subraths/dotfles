return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{ "max397574/better-escape.nvim", opts = {} },
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},

	{ "lewis6991/gitsigns.nvim", opts = {} },
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"f-person/git-blame.nvim",
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "float",
			})
			vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<cr>")
			vim.keymap.set("t", "<C-\\>", "<cmd>ToggleTerm<cr>")
		end,
	},
}
