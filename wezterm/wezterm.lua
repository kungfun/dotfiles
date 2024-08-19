local wezterm = require("wezterm")
local keys = require("utils/keys")
local fonts = require("fonts/fonts")
local mux = wezterm.mux
local action = wezterm.action

local config = {
	window_decorations = "RESIZE",
	enable_tab_bar = true,
	font_size = 14,
	font = fonts.get_font(),
	color_scheme = "catppuccin-mocha",
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = 20,
		right = 10,
		top = 15,
		bottom = 10,
	},
	window_background_opacity = 0.95,
	use_fancy_tab_bar = false,
	colors = {
		tab_bar = {
			background = "rgba(0,0,0,0.95)",
		},
		scrollbar_thumb = "rgba(0,0,0)",
		background = "rgba(1,1,1)",
	},
	initial_rows = 40,
	-- background = {
	--     {
	--         source = {
	--             File = wezterm.config_dir .. "/background/darknoise.jpg",
	--         },
	--         hsb = {
	--             brightness = 0.2,
	--         },
	--         opacity = 0.95,
	--     },
	-- },
	keys = {
		keys.cmd_key(
			"R",
			action.Multiple({
				action.SendKey({ key = "\x1b" }),
				keys.multiple_actions(":w"),
			})
		),
	},
}

function get_file_name(path)
	local start, finish = path:find("[%w%s!-={-|]+[_%.].+")
	pcall(function()
		return path:sub(start, #path)
	end)
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local lbl
	for shlindex = 1, #custom_shells do
		if tab.active_pane.title:match(custom_shells[shlindex].args[1], 1, true) then
			lbl = custom_shells[shlindex].label
			break
		end
	end
	return string.format(" %-15s ", lbl or get_file_name(tab.active_pane.title) or tab.active_pane.title)
end)

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window {}
    window:gui_window():maximize()
end)

return config
