return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			ensure_installed = { "lua", "tsx", "javascript", "typescript" },
			highlight = { enable = true },
			indent = { enable = true },
			autotag = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>", -- set to `false` to disable one of the mappings
					node_incremental = "<C-space>",
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
