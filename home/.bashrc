#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
alias steamguard="/run/media/als/Work/Distrib/Linux/AppImage/steamguard"
alias cat="bat"
# ArchLinux
alias mirror="sudo reflector --verbose --country 'Russia' -l 25 --sort rate --save /etc/pacman.d/mirrorlist"
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias clean="sudo pacman -Sc"
alias info="sudo pacman -Qi"
# Git
alias add="git add ."
alias commit="git commit -m"
alias push="git push"
alias pull="git pull"
alias log="git log"
alias glo="git log --oneline"
alias diff="git diff"
alias diffs="git diff --staged"
alias restore="git restore"
# Logs
alias syslog="sudo dmesg --level=err,warn"
# YouTube
alias youtube='yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 --output "%(title)s.%(ext)s"'
alias youtubemp3='yt-dlp -x --audio-format mp3 --output "%(title)s_audio.%(ext)s"'
# inxi
alias pc="inxi -Ixxx"
alias net="inxi -Nxxx"
# Upgrade System
alias up="epm update && epm full-upgrade"
alias cc="sudo apt-get clean && sudo apt-get autoclean && sudo apt-get check && flatpak uninstall --unused -y && sudo journalctl --vacuum-time=1weeks"
# PC
alias ls="ls --color"
alias l="lsd --date '+%d.%m.%Y %H:%M' -lah"
# System folders
alias fishrc="nano /home/$USER/.config/fish/config.fish"
alias fstab="sudo nano /etc/fstab"
alias bashrc="nano ~/.bashrc"
alias zshrc="nano ~/.zshrc"
# GRUB
alias editgrub="sudo nano /etc/default/grub"
alias updategrub="sudo update-grub"
alias grubupdate="sudo update-grub"
eval "$(fzf --bash)"
