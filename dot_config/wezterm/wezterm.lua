local wezterm = require 'wezterm'

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'tokyonight'
  else
    return 'tokyonight-day'
  end
end

return {
  font = wezterm.font 'CaskaydiaCove Nerd Font Mono',
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  enable_wayland = false,
}
