return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			local options = {
				close_if_last_window = true,
				window = {
					width = 36,
					position = "right",
				},
			}
			require("neo-tree").setup(options)
			vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<cr>")
		end,
	},
--   {
--   'stevearc/oil.nvim',
--   opts = {},
--     keys = {
--       {"-", "<cmd>Oil<cr>"}
--     },
--   -- Optional dependencies
--   dependencies = { "nvim-tree/nvim-web-devicons" },
-- }
}
