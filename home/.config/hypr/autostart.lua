-- Extra autostart processes.
-- Migrated from the XFCE autostart folder + systray apps (2026-09-12).
-- Everything the old panel launched on login, in the same order as ~/.config/autostart.

o.launch_on_start("conky -c /home/$USER/.config/conky/conky.conf")
o.launch_on_start("until [ -d /mnt/Work/Distrib ]; do sleep 0.5; done && exec /usr/bin/obsidian")
o.launch_on_start("obs --minimize-to-tray")
o.launch_on_start("qbittorrent")
o.launch_on_start("env GDK_BACKEND=x11 /usr/bin/radiotray-ng")
o.launch_on_start("/home/als/.apps/TgWsProxy_linux_amd64")
o.launch_on_start("/home/als/.apps/Kotatogram -workdir /home/als/.local/share/KotatogramDesktop/ -autostart")
o.launch_on_start("blueman-applet")
o.launch_on_start("flameshot")