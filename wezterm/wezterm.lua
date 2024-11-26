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
    freetype_load_target = "Normal",
    color_scheme = 'catppuccin-mocha',
    pane_select_font_size = 72,
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
    inactive_pane_hsb = {
        saturation = 0.1,
        brightness = 0.1,
    },
    leader = { key = 'Space', mods = 'CTRL|SHIFT' },
    keys = {
        {
            key = 'w',
            mods = 'ALT',
            action = action.ActivateKeyTable {
                name = 'activate_pane',
                timeout_milliseconds = 1000,
            },
        },
        { key = 'P', mods = 'ALT', action = action.PaneSelect },
        keys.cmd_ctrl_key(
            'R',
            action.Multiple({
                action.SendKey({ key = '\x1b' }),
                keys.multiple_actions(':w'),
            })
        ),
    },

    key_tables = {
        activate_pane = {
            { key = 'LeftArrow',  action = action.ActivatePaneDirection 'Left' },
            { key = 'h',          action = action.ActivatePaneDirection 'Left' },

            { key = 'RightArrow', action = action.ActivatePaneDirection 'Right' },
            { key = 'l',          action = action.ActivatePaneDirection 'Right' },

            { key = 'UpArrow',    action = action.ActivatePaneDirection 'Up' },
            { key = 'k',          action = action.ActivatePaneDirection 'Up' },

            { key = 'DownArrow',  action = action.ActivatePaneDirection 'Down' },
            { key = 'j',          action = action.ActivatePaneDirection 'Down' },

            { key = 'g',          action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
            { key = 'v',          action = action.SplitVertical { domain = 'CurrentPaneDomain' } },

            { key = 'q',          action = action.CloseCurrentPane { confirm = false } },
        },
    },

    daemon_options = {
        stdout = '~/logs/wezterm/stdout',
        stderr = '~/logs/wezterm/stderr',
    }
}

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    -- Create a split occupying the right 1/3 of the screen
    pane:split { size = 0.3 }
    -- Create another split in the right of the remaining 2/3
    -- of the space; the resultant split is in the middle
    -- 1/3 of the display and has the focus.
    pane:split { size = 0.5 }
end)


-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
    local name = window:active_key_table()
    if name then
        name = 'TABLE: ' .. name
    end
    window:set_right_status(name or '')
end)

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

    wezterm.log_info('window id' .. wezterm.to_string(id))
    wezterm.GLOBAL.seen_windows = seen

    local colors_cache = wezterm.GLOBAL.colors_cache
    local clear_colors_cache = {}
    local clear_seen_windows = {}

    for _, workspace_window in ipairs(mux.all_windows()) do
        local window_id = workspace_window:window_id()

        for w_id, color in pairs(colors_cache) do
            wezterm.log_info('clear cache' .. wezterm.to_string(w_id))
            wezterm.log_info('clear cache' .. wezterm.to_string(window_id))
            if wezterm.to_string(w_id) == wezterm.to_string(window_id) then
                clear_colors_cache[w_id] = color
            end
        end

        for seen_window, is_seen in pairs(seen) do
            clear_seen_windows[seen_window] = false

            wezterm.log_info('clear cache seen ' .. wezterm.to_string(seen_window))
            wezterm.log_info('clear cache seen ' .. wezterm.to_string(window_id))
            if wezterm.to_string(seen_window) == wezterm.to_string(window_id) then
                clear_seen_windows[seen_window] = true
            end
        end

        wezterm.log_info(window_id)
    end

    wezterm.log_info('clear cache' .. wezterm.to_string(clear_colors_cache))

    wezterm.GLOBAL.seen_windows = clear_seen_windows
    wezterm.GLOBAL.colors_cache = clear_colors_cache


    -- if is_new_window then
    local color = colors.get_color(id)


    overrides.window_frame = {
        border_bottom_height = '0.5cell',
        border_bottom_color = color,
    }

    window:set_config_overrides(overrides)
    -- end

    -- now act upon the flag
    if is_new_window then
        window:maximize()
    end
end)

wezterm.GLOBAL.parse_count = (wezterm.GLOBAL.parse_count or 0) + 1

return config
