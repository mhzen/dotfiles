-- ## Bar ##
-- ~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local lain = require("lain")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local systray = require("config.tray")
local bling = require("bling")
--

-- Tags
-- awful.util.tagnames =  { "1", "2" , "3", "4", "5", "6", "7" }
awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }

-- Markup
local markup = lain.util.markup

-- Separators :
local sep = wibox.widget.textbox("   ")

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

local playerctl = awful.widget.watch(
    { awful.util.shell, "-c", "playerctl metadata --format '{{ artist }} - {{ title }}'" },
    2,
    function(widget, stdout)
      if (stdout == "") then
        widget:set_text(" N/A ")
      else
        widget:set_text(" " .. stdout .. " ")
      end
    end
)

-- time widget
os.setlocale(os.getenv("LANG"))

local time = wibox.widget.textclock(" %R ")
local date = wibox.widget.textclock(" %a, %e %b ")

-- local time_tooltip = awful.tooltip {
--     objects        = { time },
--     timer_function = function()
--         return os.date('Today is %A %B %d %Y\nThe time is %T')
--     end,
-- }

local mycpu = lain.widget.cpu {
  settings = function()
    widget:set_markup(" " .. cpu_now.usage .. " ")
  end
}

local mymem = lain.widget.mem {
  settings = function()
    widget.set_markup("﬙ " .. mem_now.perc .. "% ")
  end
}

local netdown = wibox.widget.textbox()
local netup = lain.widget.net {
  units = "1048576",
  settings = function()
    widget:set_markup(" " .. net_now.sent .. " " )
    netdown:set_markup(" " .. net_now.received .. " ")
  end
}

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    s.quake = lain.util.quake { app = "terminal", argname = '--class %s', height = 0.4 }

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
      buttons = {
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
        awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
      },
      widget_template = {
            {
              {
                widget = wibox.container.background,
                id = "background_role",
                forced_height = dpi(3)
              },
              {
                {
                  id     = "text_role",
                  widget = wibox.widget.textbox,
                },
                left = 8,
                right = 8,
                widget = wibox.container.margin
              },
              layout = wibox.layout.align.vertical,
            },
          id     = "background",
          widget = wibox.container.background,
      },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
          awful.button({ }, 1, function(c)
            c:activate { context = "tasklist", action = "toggle_minimization" }
          end),
          awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250} } end),
          awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
          awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        },
        layout   = {
          layout  = wibox.layout.fixed.horizontal,
          spacing = dpi(2)
        },
        widget_template = {
              {
                {
                  widget = wibox.container.background,
                  id = "background_role",
                  forced_height = dpi(3)
                },
                {
                    {
                      awful.widget.clienticon,
                      top = dpi(3),
                      bottom = dpi(4),
                      widget = wibox.container.margin
                    },
                  left = 8,
                  right = 8,
                  widget = wibox.container.margin
                },
                layout = wibox.layout.align.vertical,
              },
            id     = "background",
            widget = wibox.container.background,
        },
    }

    s.mywibox = awful.wibar {
      position = "top",
      screen = s,
      widget = {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            sep
        },
        s.mytasklist,
        { -- Right widgets
            sep,
            layout = wibox.layout.fixed.horizontal,
            -- wibox.container.background( time, "#98BB6C" ),
            playerctl,
            mymem,
            mycpu,
            netup,
            netdown,
            date,
            time,
            wibox.container.margin(systray, 3, 3, 3, 3 ),
            wibox.container.margin(s.mylayoutbox, 6, 6, 6, 6 ),
        },
      }
    }
end)
