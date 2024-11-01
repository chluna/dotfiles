local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font_with_fallback {
    { family = 'FiraCode Nerd Font', weight = 450, style = 'Normal', harfbuzz_features = { 'ss06', 'ss07' } },
    'JetBrains Mono'
}
config.font_size = 10
config.default_cursor_style = 'SteadyBar'
config.cursor_thickness = 2
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10
}

config.disable_default_key_bindings = true
local term_mod = 'SHIFT|CTRL'
local term_mod_alt = 'SHIFT|CTRL|ALT'
config.keys = {
    { key = 'c', mods = term_mod, action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = term_mod, action = act.PasteFrom 'Clipboard' },
    { key = 'F11', mods = term_mod, action = act.ToggleFullScreen },
    { key = 'n', mods = term_mod, action = act.SpawnWindow },
    { key = 't', mods = term_mod, action = act.SpawnTab 'CurrentPaneDomain'},
    { key = 'w', mods = term_mod, action = act.CloseCurrentPane { confirm = true } },
    { key = 'w', mods = term_mod_alt, action = act.CloseCurrentTab { confirm = true } },
    { key = '=', mods = term_mod, action = act.IncreaseFontSize },
    { key = '-', mods = term_mod, action = act.DecreaseFontSize },
    { key = '0', mods = term_mod, action = act.ResetFontSize },
    { key = 'F4', mods = term_mod, action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'F5', mods = term_mod, action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = '(', mods = term_mod, action = act.ActivateTabRelative(-1) },
    { key = ')', mods = term_mod, action = act.ActivateTabRelative(1) },
    { key = '{', mods = term_mod, action = act.MoveTabRelative(-1) },
    { key = '}', mods = term_mod, action = act.MoveTabRelative(1) },
    { key = 'UpArrow', mods = term_mod, action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', mods = term_mod, action = act.ActivatePaneDirection 'Down' },
    { key = 'LeftArrow', mods = term_mod, action = act.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = term_mod, action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow', mods = term_mod_alt, action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'DownArrow', mods = term_mod_alt, action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'LeftArrow', mods = term_mod_alt, action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'RightArrow', mods = term_mod_alt, action = act.AdjustPaneSize { 'Right', 1 } }
}

return config
