if status is-interactive
    # Commands to run in interactive sessions can go here
end

fastfetch
set fish_greeting
# Editor
set -gx EDITOR micro
set -gx VISUAL micro
alias steamguard="/run/media/als/Work/Distrib/Linux/AppImage/steamguard"
alias cat="bat"
# ArchLinux
alias mirror="sudo reflector --verbose --country 'Russia' -l 25 --sort rate --save /etc/pacman.d/mirrorlist"
alias upgrade="sudo reflector --verbose --country 'Russia' -l 25 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu"
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias clean="sudo pacman -Sc"
alias info="sudo pacman -Qi"
# Git
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gs="git status"
alias gph="git push"
alias gpl="git pull"
alias gl="git log"
alias glo="git log --oneline"
alias gd="git diff"
alias gds="git diff --staged"
alias gr="git restore"
# Logs
alias syslog_emerg="sudo dmesg --level=emerg,alert,crit"
alias syslog="sudo dmesg --level=err,warn"
alias xlog='grep "(EE)\|(WW)\|error\|failed" ~/.local/share/xorg/Xorg.0.log'
alias vacuum="sudo journalctl --vacuum-size=100M"
alias vacuum_time="sudo journalctl --vacuum-time=2weeks"
# YouTube
alias youtube='yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 --output "%(title)s.%(ext)s"'
alias youtubemp3='yt-dlp -x --audio-format mp3 --output "%(title)s_audio.%(ext)s"'
# Backup
alias tm="sudo timeshift"
alias tmc="sudo timeshift --create"
alias tmd="sudo timeshift --delete"
alias tmda="sudo timeshift --delete-all"
alias tml="sudo timeshift --list"
# Fastfetch
alias pc="inxi -Ixxx"
alias net="inxi -Nxxx"
# Upgrade System
alias up="epm update && epm full-upgrade"
alias cc="sudo apt-get clean && sudo apt-get autoclean && sudo apt-get check && flatpak uninstall --unused -y && sudo journalctl --vacuum-time=1weeks"
alias c="clear"
alias find="epmqa"
alias search="epmqa"
alias poisk="epmqa"
# PC
alias son="sudo systemctl suspend"
alias reboot="systemctl reboot"
alias r="systemctrl reboot"
alias ls="ls --color"
alias l="lsd --date '+%d.%m.%Y %H:%M' -lah"
# Flatpak
alias fli="flatpak install --noninteractive -y flathub"
alias flr="flatpak remove --noninteractive -y"
alias fr="flatpak repair"
alias fl="flatpak list"
# System folders
alias fstab="sudo vim /etc/fstab"
alias bashrc="vim ~/.bashrc"
alias zshrc="vim ~/.zshrc"
alias bashrc="vim .bashrc"
# GRUB
alias grubedit="sudo vim /etc/default/grub"
alias editgrub="sudo vim /etc/default/grub"
alias upgrub="sudo update-grub"
alias grubup="sudo update-grub"
uv generate-shell-completion fish | source
zoxide init fish | source
