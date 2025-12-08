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
  left = 1,
  right = 1,
  top = 1,
  bottom = 1,
}
config.hide_tab_bar_if_only_one_tab = true
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
local action = wezterm.action
config.keys = {
    {
        key = "-",
        mods = "LEADER",
        action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },

    {
        key = "\\",
        mods = "LEADER",
        action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "h",
        mods = "CTRL|SHIFT",
        action = action.AdjustPaneSize({ "Left", 5 }),
    },
    {
        key = "l",
        mods = "CTRL|SHIFT",
        action = action.AdjustPaneSize({ "Right", 5 }),
    },
    {
        key = "j",
        mods = "CTRL|SHIFT",
        action = action.AdjustPaneSize({ "Down", 5 }),
    },
    {
        key = "k",
        mods = "CTRL|SHIFT",
        action = action.AdjustPaneSize({ "Up", 5 }),
    },
        {
        key = "m",
        mods = "LEADER",
        action = action.TogglePaneZoomState,
    },
    {
        key = "c",
        mods = "LEADER",
        action = action.SpawnTab("CurrentPaneDomain"),
    },

    {
        key = "p",
        mods = "LEADER",
        action = action.ActivateTabRelative(-1),
    },
    {
        key = "n",
        mods = "LEADER",
        action = action.ActivateTabRelative(1),
    },
    {
        key = "[",
        mods = "LEADER",
        action = action.ActivateCopyMode
    },
    {
        key = "h",
        mods = "CTRL",
        action = wezterm.action.ActivatePaneDirection "Left",
    },
    {
        key = "j",
        mods = "CTRL",
        action = wezterm.action.ActivatePaneDirection "Down",
    },
    {
        key = "k",
        mods = "CTRL",
        action = wezterm.action.ActivatePaneDirection "Up",
    },
    {
        key = "l",
        mods = "CTRL",
        action = wezterm.action.ActivatePaneDirection "Right",
    },
}
-- config.keys = {
--   {
--     key = '"',
--     mods = 'CTRL|SHIFT|ALT',
--     action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
--   },
--   {
--     key = ':',
--     mods = 'CTRL|SHIFT|ALT',
--     action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
--   },
--   {
--     key = 'H',
--     mods = 'CTRL|SHIFT|ALT',
--     action = wezterm.action.AdjustPaneSize { "Left", 1 },
--   },
--   {
--     key = 'J',
--     mods = 'CTRL|SHIFT|ALT',
--     action = wezterm.action.AdjustPaneSize { "Down", 1 },
--   },
--   {
--     key = 'K',
--     mods = 'CTRL|SHIFT|ALT',
--     action = wezterm.action.AdjustPaneSize { "Up", 1 },
--   },
--   {
--     key = 'L',
--     mods = 'CTRL|SHIFT|ALT',
--     action = wezterm.action.AdjustPaneSize { "Right", 1 },
--   },
--   {
--     key = 'H',
--     mods = 'CTRL|SHIFT',
--     action = wezterm.action.ActivatePaneDirection "Left",
--   },
--   {
--     key = 'J',
--     mods = 'CTRL|SHIFT',
--     action = wezterm.action.ActivatePaneDirection "Down",
--   },
--   {
--     key = 'K',
--     mods = 'CTRL|SHIFT',
--     action = wezterm.action.ActivatePaneDirection "Up",
--   },
--   {
--     key = 'L',
--     mods = 'CTRL|SHIFT',
--     action = wezterm.action.ActivatePaneDirection "Right",
--   },
-- }

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  -- config.font = wezterm.font 'JetbrainsMono Nerd Font Mono'
  config.default_prog = { 'fish', '-l' }
  -- config.use_fancy_tab_bar = false
  -- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
elseif wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'pwsh.exe' }
  config.default_domain = 'WSL:Ubuntu'
end

return config
