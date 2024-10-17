local wezterm = require('wezterm')
local keys = require('utils/keys')
local fonts = require('fonts/fonts')
local colors = require('colors/colors')
local mux = wezterm.mux
local action = wezterm.action

wezterm.GLOBAL.colors_cache = wezterm.GLOBAL.colors_cache or {}

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
    background = {
        {
            source = {
                File = wezterm.config_dir .. '/background/darknoise.jpg',
            },
            hsb = {
                brightness = 0.2,
            },
            opacity = 0.95,
        },
    },
    keys = {
        keys.cmd_key(
            'R',
            action.Multiple({
                action.SendKey({ key = '\x1b' }),
                keys.multiple_actions(':w'),
            })
        ),
    },
    daemon_options = {
        stdout = '~/logs/wezterm/stdout',
        stderr = '~/logs/wezterm/stderr',
    }
}

-- function get_file_name(path)
--     local start, finish = path:find('[%w%s!-={-|]+[_%.].+')
--     pcall(function()
--         return path:sub(start, #path)
--     end)
-- end
--
-- wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
--     local lbl
--     for shlindex = 1, #custom_shells do
--         if tab.active_pane.title:match(custom_shells[shlindex].args[1], 1, true) then
--             lbl = custom_shells[shlindex].label
--             break
--         end
--     end
--     return string.format(' %-15s ', lbl or get_file_name(tab.active_pane.title) or tab.active_pane.title)
-- end)
--
wezterm.on('gui-startup', function()
    local tab, pane, window = mux.spawn_window {}

    local id = tostring(window:window_id())

    local color = colors.get_color(id)
    local overrides = window.get_config_overrides()
    local window_frame = {
        border_bottom_height = '0.5cell',
        border_bottom_color = color,
    }

    overrides.window_frame = window_frame
    window.set_config_overrides(overrides)

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

    if is_new_window then
        local color = colors.get_color(id)

        wezterm.GLOBAL.seen_windows = seen

        overrides.window_frame = {
            border_bottom_height = '0.5cell',
            border_bottom_color = color,
        }

        window:set_config_overrides(overrides)
    end

    -- now act upon the flag
    if is_new_window then
        window:maximize()
    end
end)

wezterm.GLOBAL.parse_count = (wezterm.GLOBAL.parse_count or 0) + 1

wezterm.on('update-right-status', function(window, pane)
    local id = tostring(window:window_id())

    local colors_cache = wezterm.GLOBAL.colors_cache

    if colors_cache[id] ~= nil then
        window:set_right_status(id .. tostring(colors_cache[id]) .. ': Reloads=' .. tostring(wezterm.GLOBAL.parse_count))
    else
        window:set_right_status(id .. ': Reloads=' .. tostring(wezterm.GLOBAL.parse_count))
    end
end)

return config
