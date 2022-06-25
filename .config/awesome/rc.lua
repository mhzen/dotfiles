pcall(require, "luarocks.loader")

-- Libraries
local awful = require("awful")
require("awful.autofocus")
local gfs = require("gears.filesystem")
local beautiful = require("beautiful")

-- Change this variable to change theme
local chosen_theme = "kanagawa"
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
home = os.getenv("HOME") or "/home/zen"

require("config.notifs")
require("config.menu")
require("config.powermenu")
require("config.keys")
require("config.rules")
require("config.layouts")
require("config.bar")
require("config.wall")

-- Autostarts
do
  local cmds =
  {
    "nm-applet",
    "blueman-applet",
    "pa-applet",
    "picom -b"
  }

  for _,i in pairs(cmds) do
    awful.spawn.easy_async_with_shell(string.format("pgrep -u $USER -x %s > /dev/null || %s", i, i ))
  end
end

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
