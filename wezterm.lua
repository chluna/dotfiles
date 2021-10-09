local wezterm = require 'wezterm';
return {
    -- Color schemes
    color_scheme = "Monokai Remastered",
    -- color_scheme = "Monokai Soda",
    -- color_scheme = "Monokai Vivid",
    -- color_scheme = "Symfonic",
   
    -- Tabs
    hide_tab_bar_if_only_one_tab = true,

    -- Window
    adjust_window_size_when_changing_font_size = false,
    window_padding = {
        left    = 10,
        right   = 10,
        top     = 10,
        bottom  = 10,
    },

    -- Font
    font = wezterm.font_with_fallback({
        "FiraCode Nerd Font Mono",
        "JetBrains Mono",
        "Noto Color Emoji",
    }),
    font_size = 10.0,

    -- Scroll
    scrollback_lines = 10000,
    enable_scroll_bar = true,

    -- Keybinds
    -- disable default assignments for modifiers using Super
    keys = {
        {key="c", mods="SUPER", action="DisableDefaultAssignment"},
        {key="v", mods="SUPER", action="DisableDefaultAssignment"},
        {key="m", mods="SUPER", action="DisableDefaultAssignment"},
        {key="n", mods="SUPER", action="DisableDefaultAssignment"},
        {key="-", mods="SUPER", action="DisableDefaultAssignment"},
        {key="=", mods="SUPER", action="DisableDefaultAssignment"},
        {key="0", mods="SUPER", action="DisableDefaultAssignment"},
        {key="t", mods="SUPER", action="DisableDefaultAssignment"},
        {key="w", mods="SUPER", action="DisableDefaultAssignment"},
        {key="1", mods="SUPER", action="DisableDefaultAssignment"},
        {key="2", mods="SUPER", action="DisableDefaultAssignment"},
        {key="3", mods="SUPER", action="DisableDefaultAssignment"},
        {key="4", mods="SUPER", action="DisableDefaultAssignment"},
        {key="5", mods="SUPER", action="DisableDefaultAssignment"},
        {key="6", mods="SUPER", action="DisableDefaultAssignment"},
        {key="7", mods="SUPER", action="DisableDefaultAssignment"},
        {key="8", mods="SUPER", action="DisableDefaultAssignment"},
        {key="9", mods="SUPER", action="DisableDefaultAssignment"},
        {key="r", mods="SUPER", action="DisableDefaultAssignment"},
        {key="k", mods="SUPER", action="DisableDefaultAssignment"},
        {key="f", mods="SUPER", action="DisableDefaultAssignment"},
    }
}
