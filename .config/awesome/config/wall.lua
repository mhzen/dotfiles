-- ## Wall ##
-- ~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local bling = require("bling")

-- set wallaper via bling's
local function set_wallpaper(s)
  bling.module.wallpaper.setup{
    set_function = bling.module.wallpaper.setters.random,
    wallpaper = string.format("%s/.local/share/wallpapers", home),
    change_timer = 1801,
    position = "maximized",
    background = "#424242"
  }
end

-- reapply wallpaper everytime screen changes
screen.connect_signal("property::geometry", set_wallpaper)

-- apply wallpaper for each screen
awful.screen.connect_for_each_screen(function(s)
  set_wallpaper(s)
end)
