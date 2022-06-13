-- ## Bar ##
-- ~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local gears = require("gears")
local awful = require("awful")
local watch = require('awful.widget.watch')
local wibox = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local helpers = require("config.helpers")
local dpi = xresources.apply_dpi
local hotkeys_popup = require('awful.hotkeys_popup')
local bling = require("bling")
--

-- Tags
awful.util.tagnames =  { "1", "2" , "3", "4", "5", "6", "7" }

-- Widget update interval
local interval = 60

-- Markup
local markup = lain.util.markup

-- Separators :
local sep = wibox.widget.textbox(" ")

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- textclock widget
os.setlocale(os.getenv("LANG"))
local clock = wibox.widget.textclock(markup.fg.color("#D9E0EE", ' %R '))
-- local clockicon = wibox.widget.imagebox(beautiful.widget.clock)
local clockicon = wibox.widget.textbox(markup.font(beautiful.icon, ""))

-- cpu
local cpuicon = wibox.widget.imagebox(beautiful.widget.cpu)
local mycpu = lain.widget.cpu {
  settings = function()
    widget:set_markup(markup.fg.color("#FAE3B0", cpu_now.usage .. "%"))
  end
}

-- memory
local memicon = wibox.widget.imagebox(beautiful.widget.mem)
local mem = lain.widget.mem {
  settings = function()
    widget:set_markup(markup.fg.color("#96CDFB", mem_now.perc .. "%"))
  end
}

-- volume
local volicon = wibox.widget.imagebox(beautiful.widget.vol)
local volume = lain.widget.alsa {
  settings = function()
    if volume_now.status == "off" then
        volicon:set_image(beautiful.widget.vol_off) 
    elseif tonumber(volume_now.level) == 0 then
        volicon:set_image(beautiful.widget.vol_no) 
    elseif tonumber(volume_now.level) <= 50 then
        volicon:set_image(beautiful.widget.vol_low) 
    else
        volicon:set_image(beautiful.widget.vol) 
    end
    widget:set_markup(markup.fg.color("#ABE9B3", " " .. volume_now.level .. "%"))
  end
}

-- Keybindings for the volume icon
volume.widget:buttons(awful.util.table.join(
    awful.button({}, 3, function() -- right click
        os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("%s set %s 5%%+", volume.cmd, volume.channel))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("%s set %s 5%%-", volume.cmd, volume.channel))
        volume.update()
    end)
))

local art = wibox.widget {
    image = "default_image.png",
    resize = true,
    forced_height = dpi(80),
    forced_width = dpi(80),
    widget = wibox.widget.imagebox
}

local name_widget = wibox.widget {
    markup = 'No players',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local title_widget = wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local artist_widget = wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

-- Get Song Info
local playerctl = bling.signal.playerctl.lib()
playerctl:connect_signal("metadata",
                       function(_, title, artist, album_path, album, new, player_name)
    -- Set art widget
    art:set_image(gears.surface.load_uncached(album_path))

    -- Set player name, title and artist widgets
    name_widget:set_markup_silently(player_name)
    title_widget:set_markup_silently(title)
    artist_widget:set_markup_silently(artist)
end)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     --[[ awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end), ]]
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)
    bling.module.wallpaper.setup{
      set_function = bling.module.wallpaper.setters.random,
      wallpaper = {"/home/h/.local/share/backgrounds"},
      change_timer = 1801,
      position = "maximized",
      background = "#424242"
    }

    -- Each screen has its own tag table.
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        widget_template = {
          {
            {
              {
                {
                  id = "icon_role",
                  widget = wibox.widget.imagebox,
                },
                -- margins = 4,
                top = 5,
                bottom = 5,
                right = 4,
                left = 2,
                widget = wibox.container.margin,
              },
              {
                id = "text_role",
                widget = wibox.widget.textbox,
              },
              layout = wibox.layout.fixed.horizontal,
            },
            left = 5,
            right = 5,
            widget = wibox.container.margin
          },
          id = "background_role",
          widget = wibox.container.background,
        },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist
        },
        { -- Middle widget
            layout = wibox.layout.fixed.horizontal,
            s.mytasklist
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- wibox.container.margin(clockicon, 6, 0, 6, 6),
            -- clockicon,
            clock,
            wibox.container.margin(wibox.widget.systray(), 3, 3, 3, 3 ),
            wibox.container.margin(s.mylayoutbox, 3, 3, 3, 3 ),
        },
    }
end)

