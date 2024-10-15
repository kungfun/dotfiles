local wezterm = require('wezterm')
local keys = require('utils/keys')
local helpers = require('utils/helpers')
local fonts = require('fonts/fonts')
local mux = wezterm.mux
local action = wezterm.action

local config = {
    window_decorations = 'RESIZE',
    enable_tab_bar = true,
    font_size = 14,
    font = fonts.get_font(),
    color_scheme = 'catppuccin-mocha',
    window_close_confirmation = 'NeverPrompt',
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
            background = 'rgba(0,0,0,0.95)',
        },
        scrollbar_thumb = 'rgba(0,0,0)',
        background = 'rgba(1,1,1)',
    },
    initial_rows = 40,
    -- background = {
    --     {
    --         source = {
    --             File = wezterm.config_dir .. '/background/darknoise.jpg',
    --         },
    --         hsb = {
    --             brightness = 0.2,
    --         },
    --         opacity = 0.95,
    --     },
    -- },
    keys = {
        keys.cmd_key(
            'R',
            action.Multiple({
                action.SendKey({ key = '\x1b' }),
                keys.multiple_actions(':w'),
            })
        ),
    },
}

function get_file_name(path)
    local start, finish = path:find('[%w%s!-={-|]+[_%.].+')
    pcall(function()
        return path:sub(start, #path)
    end)
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local lbl
    for shlindex = 1, #custom_shells do
        if tab.active_pane.title:match(custom_shells[shlindex].args[1], 1, true) then
            lbl = custom_shells[shlindex].label
            break
        end
    end
    return string.format(' %-15s ', lbl or get_file_name(tab.active_pane.title) or tab.active_pane.title)
end)

wezterm.on('gui-startup', function()
    local tab, pane, window = mux.spawn_window {}
    window:gui_window():maximize()
end)

wezterm.on('window-config-reloaded', function(window, pane)
    -- approximately identify this gui window, by using the associated mux id
    local id = tostring(window:window_id())
    local overrides = window:get_config_overrides() or {}

    -- maintain a mapping of windows that we have previously seen before in this event handler
    local seen = wezterm.GLOBAL.seen_windows or {}
    -- set a flag if we haven't seen this window before
    local is_new_window = not seen[id]
    -- and update the mapping
    seen[id] = true
    wezterm.GLOBAL.seen_windows = seen

    local colors = {
        'grey',
        'red',
        'lime',
        'yellow',
        'blue',
        'fuchsia',
        'aqua',
        'white',
        'maroon',
        'green',
        'navy',
        'purple',
        'teal',
        'silver',
        'AliceBlue',
        'AntiqueWhite',
        'Aqua',
        'Aquamarine',
        'Azure',
        'Beige',
        'Bisque',
        'Black',
        'BlanchedAlmond',
        'Blue',
        'BlueViolet',
        'Brown',
        'BurlyWood',
        'CadetBlue',
        'Chartreuse',
        'Chocolate',
        'Coral',
        'CornflowerBlue',
        'Cornsilk',
        'Crimson',
        'Cyan',
        'DarkBlue',
        'DarkCyan',
        'DarkGoldenRod',
        'DarkGray',
        'DarkGrey',
        'DarkGreen',
        'DarkKhaki',
        'DarkMagenta',
        'DarkOliveGreen',
        'Darkorange',
        'DarkOrchid',
        'DarkRed',
        'DarkSalmon',
        'DarkSeaGreen',
        'DarkSlateBlue',
        'DarkSlateGray',
        'DarkSlateGrey',
        'DarkTurquoise',
        'DarkViolet',
        'DeepPink',
        'DeepSkyBlue',
        'DimGray',
        'DimGrey',
        'DodgerBlue',
        'FireBrick',
        'FloralWhite',
        'ForestGreen',
        'Fuchsia',
        'Gainsboro',
        'GhostWhite',
        'Gold',
        'GoldenRod',
        'Gray',
        'Grey',
        'Green',
        'GreenYellow',
        'HoneyDew',
        'HotPink',
        'IndianRed',
        'Indigo',
        'Ivory',
        'Khaki',
        'Lavender',
        'LavenderBlush',
        'LawnGreen',
        'LemonChiffon',
        'LightBlue',
        'LightCoral',
        'LightCyan',
        'LightGoldenRodYellow',
        'LightGray',
        'LightGrey',
        'LightGreen',
        'LightPink',
        'LightSalmon',
        'LightSeaGreen',
        'LightSkyBlue',
        'LightSlateGray',
        'LightSlateGrey',
        'LightSteelBlue',
        'LightYellow',
        'Lime',
        'LimeGreen',
        'Linen',
        'Magenta',
        'Maroon',
        'MediumAquaMarine',
        'MediumBlue',
        'MediumOrchid',
        'MediumPurple',
        'MediumSeaGreen',
        'MediumSlateBlue',
        'MediumSpringGreen',
        'MediumTurquoise',
        'MediumVioletRed',
        'MidnightBlue',
        'MintCream',
        'MistyRose',
        'Moccasin',
        'NavajoWhite',
        'Navy',
        'OldLace',
        'Olive',
        'OliveDrab',
        'Orange',
        'OrangeRed',
        'Orchid',
        'PaleGoldenRod',
        'PaleGreen',
        'PaleTurquoise',
        'PaleVioletRed',
        'PapayaWhip',
        'PeachPuff',
        'Peru',
        'Pink',
        'Plum',
        'PowderBlue',
        'Purple',
        'Red',
        'RosyBrown',
        'RoyalBlue',
        'SaddleBrown',
        'Salmon',
        'SandyBrown',
        'SeaGreen',
        'SeaShell',
        'Sienna',
        'Silver',
        'SkyBlue',
        'SlateBlue',
        'SlateGray',
        'SlateGrey',
        'Snow',
        'SpringGreen',
        'SteelBlue',
        'Tan',
        'Teal',
        'Thistle',
        'Tomato',
        'Turquoise',
        'Violet',
        'Wheat',
        'White',
        'WhiteSmoke',
        'Yellow',
        'YellowGreen'
    }

    local color = helpers.get_random_entry(colors)

    overrides.window_frame = {
        border_left_width = '0.5cell',
        border_right_width = '0.5cell',
        border_bottom_height = '0.25cell',
        border_top_height = '0.25cell',
        border_left_color = color,
        border_right_color = color,
        border_bottom_color = color,
        border_top_color = color,
    }


    window:set_config_overrides(overrides)
    -- now act upon the flag
    if is_new_window then
        window:maximize()
    end
end)

return config
