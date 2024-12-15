-- Pull in the wezterm API
local wezterm                   = require 'wezterm'
local act                       = wezterm.action

-- Pull in plugns
local workspace_switcher        = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

-- This will hold the configuration.
local config                    = wezterm.config_builder()

workspace_switcher.zoxide_path  = "/opt/homebrew/bin/zoxide"

-- Create a domain (mux server) and automatically connect to it on start.
-- The shell will be directly connected to the default workspace.
config.unix_domains             = {
    {
        name = 'unix',
    },
}
config.default_gui_startup_args = { 'connect', 'unix' }

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

config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
config.font_size = 18
config.line_height = 1.15

config.enable_scroll_bar = false
config.window_decorations = 'RESIZE'
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- Do not render native GUI tab bar
config.use_fancy_tab_bar = false

-- Leader is the same as my old tmux prefix
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    -- splitting
    {
        mods   = "LEADER",
        key    = "x",
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
        mods   = "LEADER",
        key    = "v",
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
    {
        key = "s",
        mods = "LEADER",
        action = workspace_switcher.switch_workspace(),
    },
    {
        key = "S",
        mods = "LEADER",
        action = workspace_switcher.switch_to_prev_workspace(),
    },
    -- Attach to muxer
    {
        key = 'a',
        mods = 'LEADER',
        action = act.AttachDomain 'unix',
    },

    -- Detach from muxer
    {
        key = 'd',
        mods = 'LEADER',
        action = act.DetachDomain { DomainName = 'unix' },
    },
    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),
}

wezterm.on('update-status', function(window, _)
    local color_scheme = window:effective_config().resolved_palette
    -- Note the use of wezterm.color.parse here, this returns
    -- a Color object, which comes with functionality for lightening
    -- or darkening the colour (amongst other things).
    local bg = wezterm.color.parse(color_scheme.background)
    local fg = color_scheme.foreground

    local segment_bg
    if get_appearance():find('Dark') then
        segment_bg = bg:lighten(0.15)
    else
        segment_bg = bg:darken(0.15)
    end

    window:set_right_status(wezterm.format {
        { Attribute = { Underline = 'Single' } },
        { Attribute = { Italic = true } },
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { Color = fg } },
        { Background = { Color = segment_bg } },
        { Text = window:active_workspace() },
    })
end)

-- and finally, return the configuration to wezterm
return config
