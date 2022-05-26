---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local themes_path = string.format("%s/.config/awesome/themes/", os.getenv("HOME"))

local theme = {}

theme.font          = "Roboto Bold 10"
theme.icon          = "Font Awesome 6 Free Regular 10"

theme.bg_normal     = "#000000"
-- theme.bg_focus      = "#131721"
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = theme.bg_normal
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

-- theme.fg_normal     = "#BFBDB6"
theme.fg_normal     = "#66707A"
theme.fg_focus      = "#F3F4F5"
theme.fg_urgent     = "#F07178"
theme.fg_minimize   = "#272D38"

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.border_normal = theme.fg_minimize
theme.border_focus  = theme.fg_normal
theme.border_marked = theme.fg_urgent

theme.taglist_spacing = dpi(4)
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_fg_empty = theme.fg_normal
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_urgent	= theme.fg_urgent

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
--[[ local taglist_square_size = dpi(10)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
) ]]

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(30)
theme.menu_width  = dpi(200)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path.."default/wall.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

theme.widget = {}
theme.widget.clock = themes_path.."default/widget/clock.png"
theme.widget.vol = themes_path.."default/widget/volume-high.png"
theme.widget.vol_low = themes_path.."default/widget/volume-medium.png"
theme.widget.vol_no = themes_path.."default/widget/volume-low.png"
theme.widget.vol_off = themes_path.."default/widget/volume-off.png"
theme.widget.cal = themes_path.."default/widget/calendar.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- For tabbed only
theme.tabbed_spawn_in_tab = true  -- whether a new client should spawn into the focused tabbing container

-- For tabbar in general
theme.tabbar_ontop  = false
theme.tabbar_radius = 0                -- border radius of the tabbar
theme.tabbar_style = "default"         -- style of the tabbar ("default", "boxes" or "modern")
theme.tabbar_font = theme.font          -- font of the tabbar
theme.tabbar_size = dpi(24)                 -- size of the tabbar
theme.tabbar_position = "top"          -- position of the tabbar
--[[ theme.tabbar_bg_normal = "#000000"     -- background color of the focused client on the tabbar
theme.tabbar_fg_normal = "#ffffff"     -- foreground color of the focused client on the tabbar
theme.tabbar_bg_focus  = "#1A2026"     -- background color of unfocused clients on the tabbar
theme.tabbar_fg_focus  = "#ff0000"     -- foreground color of unfocused clients on the tabbar
theme.tabbar_bg_focus_inactive = nil   -- background color of the focused client on the tabbar when inactive
theme.tabbar_fg_focus_inactive = nil   -- foreground color of the focused client on the tabbar when inactive
theme.tabbar_bg_normal_inactive = nil  -- background color of unfocused clients on the tabbar when inactive
theme.tabbar_fg_normal_inactive = nil  -- foreground color of unfocused clients on the tabbar when inactive ]]
theme.tabbar_disable = false           -- disable the tab bar entirely

-- the following variables are currently only for the "modern" tabbar style
theme.tabbar_color_close = "#f9929b" -- chnges the color of the close button
theme.tabbar_color_min   = "#fbdf90" -- chnges the color of the minimize button
theme.tabbar_color_float = "#ccaced" -- chnges the color of the float button

-- theme.window_switcher_widget_bg = "#000000"              -- The bg color of the widget
-- theme.window_switcher_widget_border_width = 3            -- The border width of the widget
-- theme.window_switcher_widget_border_radius = 0           -- The border radius of the widget
-- theme.window_switcher_widget_border_color = "#ffffff"    -- The border color of the widget
-- theme.window_switcher_clients_spacing = 20               -- The space between each client item
-- theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
-- theme.window_switcher_client_width = 150                 -- The width of one client widget
-- theme.window_switcher_client_height = 250                -- The height of one client widget
-- theme.window_switcher_client_margins = 10                -- The margin between the content and the border of the widget
-- theme.window_switcher_thumbnail_margins = 10             -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = false                            -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
-- theme.window_switcher_name_margins = 10                  -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center"             -- How to vertically align one clients title
-- theme.window_switcher_name_forced_width = 200            -- The width of one title
theme.window_switcher_name_font = theme.font              -- The font of all titles
-- theme.window_switcher_name_normal_color = "#ffffff"      -- The color of one title if the client is unfocused
-- theme.window_switcher_name_focus_color = "#ff0000"       -- The color of one title if the client is focused
-- theme.window_switcher_icon_valign = "center"             -- How to vertically align the one icon
-- theme.window_switcher_icon_width = 40                    -- The width of one icon

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

return theme
