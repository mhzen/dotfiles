---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local themes_path = string.format("%s/.config/awesome/themes/kanagawa", os.getenv("HOME"))

local theme = {}

theme.font          = "Iosevka Nerd Font Bold 11"
theme.icon          = "Font Awesome 6 Free Regular 10"

theme.bg_normal     = "#16161D"
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = theme.bg_normal
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

-- theme.fg_normal     = "#BFBDB6"
theme.fg_normal     = "#DCD7BA"
theme.fg_focus      = theme.fg_normal
theme.fg_urgent     = "#E82424"
theme.fg_minimize   = "#54546D"

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.border_normal = theme.fg_minimize
theme.border_focus  = theme.fg_normal
theme.border_marked = theme.fg_urgent

theme.taglist_spacing = dpi(4)
theme.taglist_fg_focus = theme.fg_normal
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_fg_empty = theme.fg_minimize
theme.tasklist_bg_focus = theme.fg_focus
theme.taglist_bg_focus = theme.fg_focus

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

layouts_path = string.format("%s/layouts", themes_path)

-- -- You can use your own layout icons like this:
theme.layout_fairh = layouts_path.."/fairhw.png"
theme.layout_fairv = layouts_path.."/fairvw.png"
theme.layout_floating  = layouts_path.."/floatingw.png"
theme.layout_magnifier = layouts_path.."/magnifierw.png"
theme.layout_max = layouts_path.."/maxw.png"
theme.layout_fullscreen = layouts_path.."/fullscreenw.png"
theme.layout_tilebottom = layouts_path.."/tilebottomw.png"
theme.layout_tileleft   = layouts_path.."/tileleftw.png"
theme.layout_tile = layouts_path.."/tilew.png"
theme.layout_tiletop = layouts_path.."/tiletopw.png"
theme.layout_spiral  = layouts_path.."/spiralw.png"
theme.layout_dwindle = layouts_path.."/dwindlew.png"
theme.layout_cornernw = layouts_path.."/cornernww.png"
theme.layout_cornerne = layouts_path.."/cornernew.png"
theme.layout_cornersw = layouts_path.."/cornersww.png"
theme.layout_cornerse = layouts_path.."/cornersew.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

return theme
