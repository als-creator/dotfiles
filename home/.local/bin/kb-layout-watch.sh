#!/usr/bin/env bash
# kb-layout-watch.sh — per-window keyboard layout for X11
# (XFCE, i3, bspwm, openbox, GNOME, KDE; safe no-op on Wayland).
#
# Watches the active window via the EWMH root property _NET_ACTIVE_WINDOW and
# applies the layout configured for that window's title/WM_CLASS by calling
# setxkbmap. The `ru` and `us` groups both stay active (toggle on Ctrl+Shift),
# but on focus change the active group is reset to the one the window wants,
# so the terminal running opencode lands on Russian and everything else on
# English.
#
# Rules live in ~/.config/kb-layout-watch.conf (PATTERN=LAYOUT, last match wins;
# the pattern is a case-insensitive regex matched against _NET_WM_NAME and
# WM_CLASS). GUI apps resetting their own group toggle state is expected — the
# window's configured group is reapplied on every refocus.
#
# Wayland (sway/hyprland) has no per-window layouts, so the script exits early
# when WAYLAND_DISPLAY is set; it is safe to autostart from any environment.
#
# Depends on: xprop (xorg-xprop), setxkbmap (xorg-setxkbmap), flock (util-linux).

set -u

CONF="${KB_LAYOUT_WATCH_CONF:-$HOME/.config/kb-layout-watch.conf}"
LOCK="${XDG_RUNTIME_DIR:-$HOME/.cache}/kb-layout-watch.lock"

# --- Guards: X11 only, and a single instance ---------------------------------
[ -n "${DISPLAY:-}" ] || exit 0
[ -z "${WAYLAND_DISPLAY:-}" ] || exit 0
command -v xprop >/dev/null 2>&1 || exit 0
command -v setxkbmap >/dev/null 2>&1 || exit 0

exec 9>"$LOCK"
flock -n 9 || exit 0

# --- Defaults ----------------------------------------------------------------
DEFAULT=us
MODEL=logitech_base
OPTIONS=grp:ctrl_shift_toggle,compose:ralt
POLL_MS=300
RULES=()

# --- Config ------------------------------------------------------------------
if [ -r "$CONF" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        case "$line" in
            \#*|"") continue ;;
            DEFAULT=*) DEFAULT="${line#DEFAULT=}" ;;
            MODEL=*)   MODEL="${line#MODEL=}" ;;
            OPTIONS=*) OPTIONS="${line#OPTIONS=}" ;;
            POLL_MS=*) POLL_MS="${line#POLL_MS=}" ;;
            *=*)
                pat="${line%%=*}"
                [ -n "${pat// /}" ] || continue
                RULES+=("$pat" "${line#*=}")
                ;;
        esac
    done <"$CONF"
fi

# --- Helpers -----------------------------------------------------------------
# Subject = whatever the window reports as its name and class, quotes stripped.
subject_of() {
    xprop -id "$1" -notype _NET_WM_NAME WM_CLASS 2>/dev/null \
        | grep -E '^(_NET_WM_NAME|WM_CLASS)' \
        | sed 's/^[^=]* = //; s/"//g'
}

layout_for() {
    local subject="$1" i lay="$DEFAULT"
    for ((i = 0; i < ${#RULES[@]}; i += 2)); do
        printf '%s\n' "$subject" | grep -Eqi "${RULES[$i]}" && lay="${RULES[$((i + 1))]}"
    done
    printf '%s' "$lay"
}

# Both groups stay active (grp toggle still works); the window's group comes
# first so setxkbmap resets the active group to it.
apply_layout() {
    local primary="$1" secondary=us
    [ "$primary" = us ] && secondary=ru
    setxkbmap -model "$MODEL" -layout "$primary,$secondary" -option "$OPTIONS" 2>/dev/null
}

cleanup() { exit 0; }
trap cleanup INT TERM

# --- Main loop ---------------------------------------------------------------
last_win=""
cur_lay=""
while :; do
    win=$(xprop -root -notype _NET_ACTIVE_WINDOW 2>/dev/null | awk '{print $NF}')

    if [ -n "$win" ] && [ "$win" != 0x0 ] && [ "$win" != "$last_win" ]; then
        last_win="$win"
        subject=$(subject_of "$win")
        if [ -n "$subject" ]; then
            lay=$(layout_for "$subject")
            if [ "$lay" != "$cur_lay" ]; then
                cur_lay="$lay"
                apply_layout "$lay"
            fi
        fi
    fi

    sleep "$((POLL_MS / 1000)).$((POLL_MS % 1000 / 100))"
done