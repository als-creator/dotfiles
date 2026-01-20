if status is-interactive
    # Commands to run in interactive sessions can go here
end

fastfetch
set fish_greeting
set -gx EDITOR micro
set -gx VISUAL micro
alias clip='wgetpaste -x -X'
alias cat="bat"
alias far='sudo far2l'
alias steamguard='/run/media/als/Work/Distrib/Linux/AppImage/steamguard'
alias up="epm update && epm full-upgrade"
alias mirror='sudo reflector --verbose -l 5 -p https --sort rate --save /etc/pacman.d/mirrorlist'
uv generate-shell-completion fish | source
