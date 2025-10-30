#!/usr/bin/env bash
set -euo pipefail

# quit quietly if not in GNOME
[[ "${XDG_CURRENT_DESKTOP:-}${DESKTOP_SESSION:-}" == *GNOME* ]] || exit 0

# built-in WM keybindings
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left  "['<Shift><Super>j']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>k']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left  "['<Super>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>k']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>f']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift><Super>f']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"

# Mutter tiling
gsettings set org.gnome.mutter.keybindings toggle-tiled-left  "['<Super>h']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>l']"

# custom keybinding: Albert on Super+Space (clobbers list to just custom0)
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
  "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# free Super+Space from IM switcher
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "@as []"

# define custom0
base="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
gsettings set "$base" name "'Albert'"
gsettings set "$base" command "'albert toggle'"
gsettings set "$base" binding "'<Super>space'"

echo "GNOME: done."

