#!/usr/bin/env sh
# Shared autostart for tiling/floating WMs that have no XDG autostart
# handling of their own (XFCE/GNOME/KDE read ~/.config/autostart/*.desktop
# natively, so this only runs from i3/sway/bspwm/openbox/... configs).
#
# Mirrors the XFCE session's ~/.config/autostart/*.desktop one-to-one
# (same apps, same commands), then adds the WM essentials every bare
# window manager needs (compositor, notification daemon, network applet).
#
# Every entry is guarded: apps that aren't installed are silently skipped.

# run <command with args...>: background-launch if the first binary exists.
# Handles both PATH binaries and absolute paths.
launch() {
    bin="$1"
    shift
    case "$bin" in
        */*) [ -x "$bin" ] || return 1 ;;
        *)   [ -n "$(command -v "$bin")" ] || return 1 ;;
    esac
    "$bin" "$@" >/dev/null 2>&1 &
}

# --- XFCE autostart mirror --------------------------------------------------
launch conky -c "$HOME/.config/conky/conky.conf"

# Obsidian: wait for the work share to mount before starting (as XFCE did).
if [ -x /usr/bin/obsidian ]; then
    ( until [ -d /mnt/Work/Distrib ]; do sleep 0.5; done; exec /usr/bin/obsidian ) &
fi

launch obs --minimize-to-tray
launch qbittorrent
launch radiotray-ng
launch blueman-applet
launch flameshot

# Radio tray needs the X11 GDK backend to render (as the XFCE autostart did).
launch env GDK_BACKEND=x11 /usr/bin/radiotray-ng

# Installed as local AppImages/bundles (absolute paths).
launch "$HOME/.apps/TgWsProxy_linux_amd64"
launch "$HOME/.apps/Kotatogram" -workdir "$HOME/.local/share/KotatogramDesktop/" -autostart

# --- WM essentials -----------------------------------------------------------
launch picom -b
launch dunst
launch nm-applet
launch xfce4-power-manager