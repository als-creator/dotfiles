#!/usr/bin/env bash
# GNOME setup — applies the XFCE hotkey set + basic tweaks to a GNOME session
# (2026-09-12). GNOME stores config in dconf, so this is the equivalent of the
# i3/sway/bspwm/openbox config files for the rest of the repo.
#
# Run once after logging into GNOME:  ~/.config/gnome/apply-xfce-settings.sh

set -euo pipefail

# --- Workspaces like the numbered XFCE pager ---------------------------------
gsettings set org.gnome.desktop.wm.preferences num-workspaces 9
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.desktop.interface clock-show-date true

# --- Custom hotkeys (mirrors xfce4-keyboard-shortcuts.xml) -------------------
readonly CUSTOM=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings

NAMES=(
    "Terminal" "Launcher" "Browser" "File manager" "Editor"
    "AI agent" "Agent manager" "Screenshot" "Screenshot area" "Lock"
)
COMMANDS=(
    "foot"
    "rofi -show drun"
    "firefox"
    "thunar"
    "code --unity-launch"
    "foot -e opencode"
    "foot -e herdr"
    "flameshot full -p ~/Pictures"
    "flameshot gui"
    "loginctl lock-session"
)
BINDINGS=(
    "<Primary><Alt>t"
    "<Super>space"
    "<Super><Shift>Return"
    "<Super>e"
    "<Super>y"
    "<Super>a"
    "<Super><Primary>Return"
    "Print"
    "<Shift>Print"
    "<Super><Primary>l"
)

list=()
for i in "${!NAMES[@]}"; do
    list+=("${CUSTOM}/custom${i}/")
done
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
    "$(printf "['%s']" "${list[@]//\//\/}")"

for i in "${!NAMES[@]}"; do
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM}/custom${i}/ \
        name "${NAMES[$i]}"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM}/custom${i}/ \
        command "${COMMANDS[$i]}"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM}/custom${i}/ \
        binding "${BINDINGS[$i]}"
done

# --- Keyboard layout like XFCE (ru,us; Ctrl+Shift toggle; compose on RAlt) ---
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'ru'), ('xkb', 'us')]"
gsettings set org.gnome.desktop.input-sources xkb-options \
    "['grp:ctrl_shift_toggle', 'compose:ralt']"

# --- XF86 media keys already handled by GNOME defaults -----------------------

echo "GNOME: hotkeys applied."