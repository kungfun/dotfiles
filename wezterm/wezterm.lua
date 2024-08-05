local wezterm = require("wezterm")
local keys = require("utils/keys")
local fonts = require("fonts/fonts")
local mux = wezterm.mux
local action = wezterm.action

local config = {
    window_decorations = "RESIZE",
    enable_tab_bar = true,
    font_size = 12,
    font = fonts.get_font(),
    color_scheme = "catppuccin-mocha",
    window_padding = {
        left = 40,
        right = 20,
        top = 30,
        bottom = 20,
    },
    window_background_opacity = 0.85,
    use_fancy_tab_bar = false,
    colors = {
        tab_bar = {
            background = "rgba(0,0,0,0.85)"
        },
        scrollbar_thumb = "rgba(0,0,0)"
    },
    initial_cols = 200,
    initial_rows = 40,
    background = { {
        source = {
            File = wezterm.config_dir .. "/background/darknoise.jpg"
        },
        hsb = {
            brightness = 1,
        },
        opacity = 0.85,
    } },
    keys = {
        keys.cmd_key(
            "R",
            action.Multiple({
                action.SendKey({ key = "\x1b" }),
                keys.multiple_actions(":w"),
            })
        )
    }
}

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window {}
    window:gui_window():maximize()
end)

return config
