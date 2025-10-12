local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'GruvboxDark'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.leader = { key = 'a', mods = 'CTRL' }
config.keys = {
  {
    key = ':',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '"',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'H',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize { "Left", 1 },
  },
  {
    key = 'J',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize { "Down", 1 },
  },
  {
    key = 'K',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize { "Up", 1 },
  },
  {
    key = 'L',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize { "Right", 1 },
  },
  {
    key = 'H',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    key = 'J',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection "Down",
  },
  {
    key = 'K',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    key = 'L',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection "Right",
  },
}

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  config.font = wezterm.font 'SpaceMono Nerd Font Mono'
  config.default_prog = { 'fish', '-l' }
  -- config.use_fancy_tab_bar = false
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
elseif wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'pwsh.exe' }
  config.default_domain = 'WSL:Ubuntu'
end

return config
