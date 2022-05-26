-- ## Menu ##
-- ~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require('awful')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup')

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

local mypowermenu = {
    { "shutdown", function() awful.spawn("systemctl poweroff") end },
    { "restart", function() awful.spawn("systemctl reboot") end },
    { "logout", function() awesome.quit() end },
    { "lock", function() awful.spawn("i3lock-fancy") end },
}

local mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "power", mypowermenu},
                                    { "open terminal", terminal }
                                  }
                        })

local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymainmenu })
