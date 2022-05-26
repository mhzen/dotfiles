-- ## Keybindings ##
-- ~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful         = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local lain          = require("lain")
local beautiful     = require("beautiful")
-- local apps          = require("configuration.apps")
require("config.menu")

-- vars/misc
-- ~~~~~~~~~

-- modkey
local modkey    = "Mod4"
-- modifer keys
local shift     = "Shift"
local ctrl      = "Control"
local alt       = "Mod1"

-- Configurations
-- ~~~~~~~~~~~~~~

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


-- Mouse bindings :
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
})

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
		{description="show help", group="awesome"}),

    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
		{description = "show main menu", group = "awesome"}),

    awful.key({ modkey, ctrl }, "r", awesome.restart,
		{description = "reload awesome", group = "awesome"}),

    awful.key({ modkey, shift   }, "q", awesome.quit,
		{description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
		{description = "open a terminal", group = "launcher"}),

    awful.key({ modkey, shift }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end,
    {description = "Toggle wibar.", group = "awesome"}),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
		{description = "view previous", group = "tag"}),

    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
		{description = "view next", group = "tag"}),

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
		{description = "go back", group = "tag"}),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),

    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    awful.key({ modkey, ctrl }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),

    awful.key({ modkey, ctrl }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey, ctrl }, "n",
		function ()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
			c:activate { raise = true, context = "key.unminimize" }
			end
		end,
		{description = "restore minimized", group = "client"}),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, shift   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, shift   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),

    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),

    awful.key({ modkey, shift   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),

    awful.key({ modkey, shift   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ modkey, ctrl }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),

    awful.key({ modkey, ctrl }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),

    awful.key({ modkey, shift   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, ctrl, shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

-- Media Control :
awful.keyboard.append_global_keybindings({
	-- Volume Keys :
	awful.key({}, "XF86AudioLowerVolume", function ()
		awful.util.spawn("amixer -q -D pulse sset Master 5%-", false) end),

	awful.key({}, "XF86AudioRaiseVolume", function ()
		awful.util.spawn("amixer -q -D pulse sset Master 5%+", false) end),

	awful.key({}, "XF86AudioMute", function ()
		awful.util.spawn("amixer -D pulse set Master 1+ toggle", false) end),

	-- Media Keys :
	awful.key({}, "XF86AudioPlay", function()
		awful.util.spawn("playerctl play-pause", false) end),

	awful.key({}, "XF86AudioNext", function()
		awful.util.spawn("playerctl next", false) end),

	awful.key({}, "XF86AudioPrev", function()
		awful.util.spawn("playerctl previous", false) end),

	-- Brightness Keys :
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.util.spawn("brightnessctl set 2%+", false) end),

	awful.key({}, "XF86MonBrightnessDown", function()
		awful.util.spawn("brightnessctl set 2%-", false) end),
})

-- Standard program :
awful.keyboard.append_global_keybindings({
	-- File Manager :
 --    awful.key({ ctrl, shift }, "f", function () awful.spawn(string.format("pcmanfm")) end,
	-- 	{description = "pcmanfm", group = "file manager"}),

 --    -- Screenshots Keys :
 --    awful.key({}, "Print", function () awful.util.spawn("screenshot")end,
	-- 	{description = "Maim", group = "screenshot"}),

    -- awful.key({ modkey }, "Print", function () awful.util.spawn("screenshot-select")end,
		-- {description = "Maim", group = "screenshot"}),

	-- Rofi :
    awful.key({ modkey }, "r", function () awful.spawn(string.format("rofi -show drun")) end,
		{description = "rofi launcher", group = "launcher"}),

    awful.key({ modkey, shift }, "r", function () awful.spawn(string.format("rofi -show run")) end,
		{description = "rofi launcher", group = "launcher"}),

	-- Center Window :
	awful.key({ modkey }, "y", awful.placement.centered)
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ modkey, "Shift"   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"}),
    })
end)

-- Sloppy focus :
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = true }
end)

