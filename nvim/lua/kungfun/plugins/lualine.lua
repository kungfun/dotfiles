function transparent_theme()
	local colors = {
		black = "#202020",
		neon = "#DFFF00",
		white = "#FFFFFF",
		green = "#00D700",
		purple = "#5F005F",
		blue = "#00DFFF",
		darkblue = "#00005F",
		navyblue = "#000080",
		brightgreen = "#9CFFD3",
		gray = "#f72585",
		darkgray = "#3c3836",
		lightgray = "#504945",
		inactivegray = "#7c6f64",
		orange = "#FFAF00",
		red = "#5F0000",
		brightorange = "#C08A20",
		brightred = "#AF0000",
		cyan = "#00DFFF",
	}

	return {
		normal = {
			a = { bg = "#BF2EF0", fg = "#FFFFFF", gui = "bold" },
			b = { bg = "#4379F2", fg = "#000000" },
			c = { bg = "#000000", fg = "#FFFFFF" },
		},
		insert = {
			a = { bg = "#f72585", fg = "#000000", gui = "bold" },
			b = { bg = "#b5179e", fg = "#FFFFFF" },
			c = { bg = "#7209b7", fg = "#FFFFFF" },
		},
		visual = {
			a = { bg = "#ffe14c", fg = "#000000", gui = "bold" },
			b = { bg = "#f72585", fg = colors.white },
			c = { bg = "#fff2b2", fg = "#000000" },
		},
		replace = {
			a = { bg = "#FFFFFF", fg = "#000000", gui = "bold" },
			b = { bg = colors.cyan, fg = colors.darkblue },
			c = { bg = colors.navyblue, fg = "#FFFFFF" },
		},
		command = {
			a = { bg = "#4361ee", fg = "#FFFFFF", gui = "bold" },
			b = { bg = "#3f37c9", fg = "#FFFFFF" },
			c = { bg = "#4cc9f0", fg = "#000000" },
		},
		inactive = {
			a = { bg = colors.darkgray, fg = colors.gray, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.gray },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
	}
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = transparent_theme(),
			},
		})
	end,
}
