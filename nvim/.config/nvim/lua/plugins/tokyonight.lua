return {
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = false,
			dim_inactive = true,
			style = "day",
			sidebars = "dark",
			floats = "dark",
			cache = true,
			terminal_colors = true,
			styles = {
				keywords = { italic = true },
				comments = { reverse = false, bold = false, italic = true },
				functions = { italic = true },
				variables = { italic = true, bold = false },
			},
		},
	},
}
