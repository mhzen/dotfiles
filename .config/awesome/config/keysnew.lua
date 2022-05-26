-- ## Keybindings ##
-- ~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local lain = require("lain")
local gears = require("gears")

-- vars/misc
-- ~~~~~~~~~

-- modkey
local modkey    = "Mod4"
-- modifer keys
local shift     = "Shift"
local ctrl      = "Control"
local altkey    = "Mod1"
local quake = lain.util.quake({ app = terminal, argname = '--class %s', height = 0.5 })

-- {{{ Mouse bindings.
root.buttons(gears.table.join(
    awful.button({ }, 3, function () awful.util.rcMainMenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
local globalKeys = gears.table.join(
    -- Awesome
    awful.key({ modkey }, "F1", hotkeys_popup.show_help,
        {description = "Launches this help.", group="Awesome"}),
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
        {description = "Launches this help.", group="Awesome"}),
    awful.key({ modkey }, "r", awesome.restart,
        {description = "Reloads awesome.", group="Awesome"}),
    awful.key({ modkey }, "q", function () awful.spawn.with_shell( "killall awesome" ) end,
        {description = "Quit awesome.", group="Awesome"}),

    -- Show/Hide top wibox
    awful.key({ modkey, shift }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end,
    {description = "Toggle top wibox.", group = "Awesome"}),

    -- Super + ... function (F'x') keys.
    -- awful.key({ modkey }, "F2", function () awful.util.spawn( guiEditor ) end,
    --     {description = "Launch the text editor." , group = "Function keys" }),
    -- awful.key({ modkey }, "F3", function () awful.util.spawn( filemanager ) end,
    --     {description = "Launch the filemanager", group = "Function keys" }),
    -- awful.key({ modkey }, "F4", function () awful.util.spawn( "xfc-terminal --drop-down" ) end,
    --     {description = "Dropdown terminal.", group = "Function keys"}),

    -- Super + ...
    -- awful.key({ modkey }, "Return", function () awful.util.spawn( terminal ) end,
    --     {description = "Launch the terminal.", group="Hotkeys"}),
    -- awful.key({ modkey, shift }, "Return", function () awful.util.spawn( filemanager ) end,
    --     {description = "Launches the filemanager.", group = "Hotkeys" }),
    -- awful.key({ modkey }, "b", function () awful.util.spawn( browser ) end,
    --     {description = "Launch default browser.", group = "Hotkeys" }),
    -- awful.key({ modkey }, "e", function () awful.util.spawn( guiEditor ) end,
    --     {description = "Launch graphical text editor.", group = "Hotkeys" }),
    -- awful.key({ modkey }, "t", function () awful.util.spawn( editor ) end,
    --     {description = "Launch default terminal editor.", group = "Hotkeys" }),
    -- awful.key({ modkey }, "l", function () awful.util.spawn( lockscreen ) end,
    --     {description = "Locks the screen on demand.", group = "Hotkeys" }),
    -- awful.key({ modkey }, "c", function () awful.util.spawn( "code" ) end,
    --     {description = "Launches Visual Studio Code.", group = "Hotkeys" }),

    -- Copy primary to clipboard (terminals to gtk)
    -- awful.key({ modkey, ctrl }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
    --     {description = "Copy terminal to gtk.", group = "Hotkeys"}),
    -- -- Copy clipboard to primary (gtk to terminals)
    -- awful.key({ modkey, ctrl }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
    --     {description = "Copy gtk to terminal.", group = "Hotkeys"}),

    -- Super + ... eos apps.
    -- awful.key({ modkey, shift }, "w", function () awful.util.spawn( "eos-welcome --enable" ) end,
    --     {description = "EndeavourOS welcome app.", group = "EOS Apps" }),
    -- awful.key({ ctrl, altkey }, "l", function () awful.util.spawn( "eos-log-tool" ) end,
    --     {description = "EndeavourOS log tool.", group = "EOS Apps" }),
    -- awful.key({ modkey, shift }, "i", function () awful.util.spawn( "eos-apps-info" ) end,
    --     {description = "EndeavourOS log tool.", group = "EOS Apps" }),
    -- awful.key({ modkey, shift }, "r", function () awful.util.spawn( "reflector-simple" ) end,
    --     {description = "EndeavourOS reflector simple.", group = "EOS Apps" }),
    -- awful.key({ modkey, shift }, "m", function () awful.util.spawn( terminal .. "-e eos-rankmirrors" ) end,
    --     {description = "EndeavourOS rank mirrors.", group = "EOS Apps" }),

    -- Screenshots
    -- awful.key({ }, "Print", function () awful.util.spawn( "xfce4-screenshooter -i" ) end,
    --     {description = "Use xfce screenshooter.", group = "Screenshots" }),

    -- Layout switching
    awful.key({ altkey, shift }, "l", function () awful.tag.incmwfact( 0.05) end,
        {description = "Increase master width factor.", group = "Layout"}),
    awful.key({ altkey, shift }, "h", function () awful.tag.incmwfact(-0.05) end,
        {description = "Decrease master width factor.", group = "Layout"}),
    awful.key({ modkey, shift }, "h", function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "Increase the number of master clients.", group = "Layout"}),
    awful.key({ modkey, shift }, "l", function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "Decrease the number of master clients.", group = "Layout"}),
    awful.key({ modkey, ctrl }, "h", function () awful.tag.incncol( 1, nil, true) end,
        {description = "Increase the number of columns.", group = "Layout"}),
    awful.key({ modkey, ctrl }, "l", function () awful.tag.incncol(-1, nil, true) end,
        {description = "Decrease the number of columns.", group = "Layout"}),
    awful.key({ modkey }, "space", function () awful.layout.inc( 1) end,
        {description = "select next", group = "Layout"}),
    awful.key({ modkey, shift}, "space", function () awful.layout.inc(-1) end,
        {description = "select previous", group = "Layout"}),

    -- Tag browsing with modkey
    awful.key({ modkey }, "Left",   awful.tag.viewprev,
        {description = "View previous.", group = "Tag"}),
    awful.key({ modkey }, "Right",  awful.tag.viewnext,
        {description = "View next.", group = "Tag"}),
    awful.key({ altkey }, "Escape", awful.tag.history.restore,
        {description = "Go back.", group = "Tag"}),

     -- Tag browsing alt + tab
    awful.key({ altkey }, "Tab",   awful.tag.viewnext,
        {description = "View next.", group = "Tag"}),
    awful.key({ altkey, shift }, "Tab",  awful.tag.viewprev,
        {description = "View previous.", group = "Tag"}),

     -- Tag browsing modkey + tab
    awful.key({ modkey }, "Tab",   awful.tag.viewnext,
        {description = "View next.", group = "Tag"}),
    awful.key({ modkey, shift }, "Tab",  awful.tag.viewprev,
        {description = "View previous.", group = "Tag"}),

    -- Default client focus
    awful.key({ altkey }, "j", function () awful.client.focus.byidx( 1) end,
        {description = "Focus next by index.", group = "Client"}),
    awful.key({ altkey }, "k", function () awful.client.focus.byidx(-1) end,
        {description = "Focus previous by index.", group = "Client"}),

    -- By direction client focus
    awful.key({ modkey, altkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus down.", group = "Client"}),
    awful.key({ modkey, altkey }, "k",
        function()
            awful.Client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus up.", group = "Client"}),
    awful.key({ modkey, altkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus left.", group = "Client"}),
    awful.key({ modkey, altkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus right.", group = "Client"}),

    -- By direction client focus with arrows
    awful.key({ ctrl, modkey }, "Down",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus down.", group = "Client"}),
    awful.key({ ctrl, modkey }, "Up",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus up.", group = "Client"}),
    awful.key({ ctrl, modkey }, "Left",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus left.", group = "Client"}),
    awful.key({ ctrl, modkey }, "Right",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus right.", group = "Client"}),

    -- Layout manipulation
    awful.key({ modkey, shift   }, "j", function () awful.client.swap.byidx(  1)    end,
        {description = "Swap with next client by index.", group = "Client"}),
    awful.key({ modkey, shift   }, "k", function () awful.client.swap.byidx( -1)    end,
        {description = "Swap with previous client by index.", group = "Client"}),
    awful.key({ modkey, ctrl }, "j", function () awful.screen.focus_relative( 1) end,
        {description = "Focus the next screen.", group = "Screen"}),
    awful.key({ modkey, ctrl }, "k", function () awful.screen.focus_relative(-1) end,
        {description = "Focus the previous screen.", group = "Screen"}),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto,
        {description = "Jump to urgent client", group = "Client"}),
    awful.key({ ctrl }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "Go back.", group = "Client"}),

    -- On the fly useless gaps change
    awful.key({ altkey, ctrl}, "j", function () lain.util.useless_gaps_resize(1) end,
              {description = "Increment useless gaps.", group = "Tag"}),
    awful.key({ altkey, ctrl }, "h", function () lain.util.useless_gaps_resize(-1) end,
              {description = "Decrement useless gaps.", group = "Tag"}),

    -- Dynamic tagging
    awful.key({ modkey, shift }, "n", function () lain.util.add_tag() end,
              {description = "Add new tag.", group = "Tag"}),
    awful.key({ modkey, ctrl }, "r", function () lain.util.rename_Tag() end,
              {description = "Rename tag.", group = "Tag"}),
    awful.key({ modkey, shift }, "Left", function () lain.util.move_tag(-1) end,
              {description = "Move tag to the left.", group = "Tag"}),
    awful.key({ modkey, shift }, "Right", function () lain.util.move_tag(1) end,
              {description = "Move tag to the right", group = "Tag"}),
    awful.key({ modkey, shift }, "y", function () lain.util.delete_tag() end,
              {description = "Delete tag", group = "Tag"}),

    -- Retore window
    awful.key({ modkey, ctrl }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "Restore minimized.", group = "Client"}),

    -- ALSA volume control
    -- awful.key({ modkey, shift}, "Up",
    --     function ()
    --         os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
    --         beautiful.volume.update() end,
    --         {description = "Volumn up.", group = "Audio"}),
    -- awful.key({ modkey, shift }, "Down",
    --     function ()
    --         os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
    --         beautiful.volume.update() end,
    --         {description = "Volumn down.", group = "Audio"}),
    -- awful.key({ modkey, altkey }, "m",
    --     function ()
    --         os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
    --         beautiful.volume.update() end,
    --         {description = "Volumn mute.", group = "Audio"}),
    -- awful.key({ modkey, shift }, "m",
    --     function ()
    --         os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
    --         beautiful.volume.update() end,
    --         {description = "Volumn full.", group = "Audio"}),
    -- awful.key({ modkey, shift }, "0",
    --     function ()
    --         os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
    --         beautiful.volume.update() end,
    --         {description = "Volumn 0.", group = "Audio"}),
    awful.key({ modkey, }, "z", function () quake:toggle() end,
    {description = "quake terminal", group = "launcher"})

    -- }}}
)

local clientKeys = gears.table.join(
    awful.key({ altkey, shift }, "m", lain.util.magnify_client,
              {description = "Magnify client", group = "Client"}),
    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "Toggle fullscreen", group = "Client"}),
    awful.key({ modkey, shift }, "c", function (c) c:kill() end,
              {description = "Close", group = "Hotkeys"}),
    awful.key({ modkey, shift }, "space",  awful.client.floating.toggle,
              {description = "Toggle floating", group = "Client"}),
    awful.key({ modkey, ctrl }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "Move to master", group = "Client"}),
    awful.key({ modkey }, "o", function (c) c:move_to_screen() end,
              {description = "Move to screen", group = "Client"}),
    awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end,
              {description = "Toggle keep on top", group = "Client"}),
    awful.key({ modkey }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "Minimize", group = "Client"}),
    awful.key({ modkey }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "Maximize", group = "Client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "View tag #", group = "Tag"}
        descr_toggle = {description = "Toggle tag #", group = "Tag"}
        descr_move = {description = "Move focused client to tag #", group = "Tag"}
        descr_toggle_focus = {description = "Toggle focused client on tag #", group = "Tag"}
    end
    globalKeys = gears.table.join(globalKeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, ctrl }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, shift }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, ctrl, shift }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

local clientButtons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)
-- }}}

root.keys(globalKeys)
