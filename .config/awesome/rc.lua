pcall(require, "luarocks.loader")

-- Libraries
local awful = require("awful")
require("awful.autofocus")
local gfs = require("gears.filesystem")
local beautiful = require("beautiful")

-- Change this variable to change theme
local chosen_theme = "default"
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

require("config.notifs")
require("config.menu")
require("config.keys")
require("config.rules")
require("config.layouts")
require("config.bar")

-- Autostarts
do
  local cmds =
  {
    "nm-applet",
    "blueman-applet",
    "pa-applet"
  }

  for _,i in pairs(cmds) do
    awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || %s", i, i ))
  end
end

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
