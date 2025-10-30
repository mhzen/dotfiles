#!/usr/bin/env bash
set -euo pipefail

# quit quietly if not in Xfce
[[ "${XDG_CURRENT_DESKTOP:-}${DESKTOP_SESSION:-}" == *XFCE* ]] || exit 0

# 1) attention behavior: switch to the window’s workspace
xfconf-query -c xfwm4 -p /general/activate_action -n -t string -s switch \
  || xfconf-query -c xfwm4 -p /general/activate_action -t string -s switch

# 2) app shortcuts
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>space"  -n -t string -s "albert toggle" \
  || xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>space"  -t string -s "albert toggle"
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>Return" -n -t string -s "exo-open --launch TerminalEmulator" \
  || xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>Return" -t string -s "exo-open --launch TerminalEmulator"

# 3) wm shortcuts
wm_bind() {
  xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/$1" -n -t string -s "$2" \
    || xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/$1" -t string -s "$2"
}

# window actions
wm_bind "<Super>q"        "close_window_key"
wm_bind "<Super>f"        "maximize_window_key"
wm_bind "<Shift><Super>f" "fullscreen_key"
wm_bind "<Super>x"        "move_window_key"
wm_bind "<Super>v"        "shade_window_key"
wm_bind "<Super>b"        "stick_window_key"

# tiling (vim keys)
wm_bind "<Super>h" "tile_left_key"
wm_bind "<Super>j" "tile_down_key"
wm_bind "<Super>k" "tile_up_key"
wm_bind "<Super>l" "tile_right_key"

# workspaces 1..6
for n in {1..6}; do
  wm_bind "<Super>${n}" "workspace_${n}_key"
  wm_bind "<Shift><Super>${n}" "move_window_workspace_${n}_key"
done

echo "XFCE: done."
