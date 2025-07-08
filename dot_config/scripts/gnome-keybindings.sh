#!/usr/bin/env bash

# Check if the desktop environment is GNOME
if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
    # Set keybindings using gsettings

    # builtin keybindings
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>j']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>k']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>j']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>k']"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Super>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>f']"
    gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift><Super>f']"
    gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>h']"
    gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>l']"
    gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"

    # reserve slot
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

    # albert keybindings
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source "@as []"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Albert'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'albert toggle'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>space'
else
    echo "Not in GNOME desktop environment."
fi
