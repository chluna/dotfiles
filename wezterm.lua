local wezterm = require 'wezterm';
return {
    -- Color schemes
    -- color_scheme = "Monokai Remastered",
    color_scheme = "Monokai Soda",
    -- color_scheme = "Monokai Vivid",
    -- color_scheme = "Symfonic",
   
    -- Tabs
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,

    -- Window
    window_background_opacity = 0.9,
    adjust_window_size_when_changing_font_size = false,
    window_padding = {
        left    = 10,
        right   = 10,
        top     = 10,
        bottom  = 10,
    },
    
    -- Cursor
    default_cursor_style = "SteadyBar",

    -- Font
    font = wezterm.font_with_fallback({
        "FiraCode Nerd Font Mono",
        "Noto Color Emoji",
    }),
    font_size = 10.0,
    harfbuzz_features = {"ss06", "ss07"},

    -- Scroll
    scrollback_lines = 10000,
    enable_scroll_bar = true,

    -- Keyboard
    disable_default_key_bindings = true,
    leader = {mods="", key="VoidSymbol"},
    keys = {
        {mods="CTRL|SHIFT",         key="r",            action="ReloadConfiguration"},
        {mods="CTRL|SHIFT",         key="c",            action=wezterm.action{CopyTo="Clipboard"}},
        {mods="CTRL|SHIFT",         key="v",            action=wezterm.action{PasteFrom="Clipboard"}},
        {mods="CTRL|SHIFT",         key="n",            action="SpawnWindow"},
        {mods="LEADER",             key="t",            action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
        {mods="CTRL|SHIFT",         key="q",            action=wezterm.action{CloseCurrentTab={confirm=true}}},
        {mods="LEADER|SHIFT",       key="LeftArrow",    action=wezterm.action{ActivateTabRelative=-1}},
        {mods="LEADER|SHIFT",       key="RightArrow",   action=wezterm.action{ActivateTabRelative=1}},
        {mods="LEADER|CTRL|SHIFT",  key="LeftArrow",    action=wezterm.action{MoveTabRelative=-1}},
        {mods="LEADER|CTRL|SHIFT",  key="RightArrow",   action=wezterm.action{MoveTabRelative=1}},
        {mods="LEADER",             key="\\",           action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        {mods="LEADER",             key="-",            action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
        {mods="CTRL|SHIFT",         key="w",            action=wezterm.action{CloseCurrentPane={confirm=true}}},
        {mods="CTRL|SHIFT",         key="LeftArrow",    action=wezterm.action{ActivatePaneDirection="Left"}},
        {mods="CTRL|SHIFT",         key="RightArrow",   action=wezterm.action{ActivatePaneDirection="Right"}},
        {mods="CTRL|SHIFT",         key="UpArrow",      action=wezterm.action{ActivatePaneDirection="Up"}},
        {mods="CTRL|SHIFT",         key="DownArrow",    action=wezterm.action{ActivatePaneDirection="Down"}},
        {mods="CTRL|SHIFT|ALT",     key="LeftArrow",    action=wezterm.action{AdjustPaneSize={"Left", 1}}},
        {mods="CTRL|SHIFT|ALT",     key="RightArrow",   action=wezterm.action{AdjustPaneSize={"Right", 1}}},
        {mods="CTRL|SHIFT|ALT",     key="UpArrow",      action=wezterm.action{AdjustPaneSize={"Up", 1}}},
        {mods="CTRL|SHIFT|ALT",     key="DownArrow",    action=wezterm.action{AdjustPaneSize={"Down", 1}}},
        {mods="CTRL",               key="0",            action="ResetFontSize"},
        {mods="CTRL",               key="-",            action="DecreaseFontSize"},
        {mods="CTRL",               key="=",            action="IncreaseFontSize"},
    },
}
