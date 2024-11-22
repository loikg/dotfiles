-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return 'Dark'
end

function scheme_for_appearance(appearance)
    if appearance:find 'Dark' then
        return 'Catppuccin Mocha'
    else
        return 'Catppuccin Latte'
    end
end

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
    -- this is set by the plugin, and unset on ExitPre in Neovim
    return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == 'resize' and 'CTRL' or 'META',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                -- pass the keys through to vim/nvim
                win:perform_action({
                    SendKey = { key = key, mods = resize_or_move == 'resize' and 'CTRL' or 'META' },
                }, pane)
            else
                if resize_or_move == 'resize' then
                    win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                end
            end
        end),
    }
end

config.color_scheme = scheme_for_appearance(get_appearance())

config.font = wezterm.font 'JetbrainsMono Nerd Font Mono'
config.font_size = 18
config.line_height = 1.15

config.enable_scroll_bar = false
-- config.enable_tab_bar = false
config.window_decorations = 'RESIZE'
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.use_fancy_tab_bar = false

-- Leader is the same as my old tmux prefix
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    -- splitting
    {
        mods   = "LEADER",
        key    = "\"",
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
        mods   = "LEADER",
        key    = "%",
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    -- Maximize window
    {
        mods = 'META',
        key = 'z',
        action = wezterm.action.TogglePaneZoomState
    },
    -- activate copy mode or vim mode
    {
        key = 'Enter',
        mods = 'LEADER',
        action = wezterm.action.ActivateCopyMode
    },
    {
        mods = 'META',
        key = 'w',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        mods = 'META',
        key = 'q',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    {
        mods = 'META',
        key = 'u',
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        mods = 'META',
        key = 'p',
        action = wezterm.action.ActivateTabRelative(1)
    },
    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),
}

-- and finally, return the configuration to wezterm
return config
