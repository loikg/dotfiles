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

config.color_scheme = scheme_for_appearance(get_appearance())

config.font = wezterm.font 'JetbrainsMono Nerd Font Mono'
config.font_size = 18

config.enable_tab_bar = false
config.window_decorations = 'RESIZE'


-- and finally, return the configuration to wezterm
return config
