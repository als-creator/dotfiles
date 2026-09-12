-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Migrated from XFCE (xfce4-keyboard-shortcuts.xml, 2026-09-12).
-- Omarchy defaults are kept: SUPER+W (close window) and SUPER+C (copy) are
-- sacred, so the old XFCE uses of those keys moved elsewhere:
--   XFCE SUPER+W = browser      -> omarchy default SUPER+SHIFT+RETURN (browser)
--   XFCE SUPER+C = /usr/bin/code-> bound to SUPER+Y below (no conflict)
-- Screenshots (Print / Alt+Print) and the menu are omarchy defaults already.

-- Terminal: XFCE used Ctrl+Alt+T (and Ctrl+Alt+Cyrillic_ie = Ctrl+Alt+Q).
o.bind("CONTROL + ALT + T", "Terminal", "foot")

-- File manager: XFCE used Super+E (and Super+Cyrillic_u = the E key).
o.bind("SUPER + E", "File manager", "thunar")

-- Editor: XFCE used Super+C = "code --unity-launch %F"; moved off Super+C
-- (that's omarchy copy). Picked the free SUPER+Y comb.
o.bind("SUPER + Y", "Editor", "code --unity-launch %F")