return {
	{
		"erl-koenig/theme-hub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Optional: for themes that use lush (will be notified if a theme requires it)
			"rktjmp/lush.nvim",
		},
		config = function()
			require("theme-hub").setup({
				-- Configuration options (see below)
				install_dir = vim.fn.stdpath("data") .. "/theme-hub",
				auto_install_on_select = true,
				apply_after_install = true,
				persistent = true,
			})
			vim.keymap.set("n", "<leader>th", vim.cmd.ThemeHub)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			theme = "catpuccin",
		},
		config = function()
			require("lualine").setup()
		end,
	},
	
}
