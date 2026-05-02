#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
set -gx EDITOR nano
set -gx VISUAL nano
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
alias diff="git diff"
alias diffs="git diff --staged"
alias restore="git restore"
alias checkout='git checkout'
alias gs='git status'
alias gc='git commit -m'
alias gp='git push'
alias glo='git log —oneline —graph —all'
alias gco='git checkout'
# Logs
alias syslog="sudo dmesg --level=err,warn"
# YouTube
alias youtube='yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 --output "%(title)s.%(ext)s"'
alias youtubemp3='yt-dlp -x --audio-format mp3 --output "%(title)s_audio.%(ext)s"'
# inxi
alias pc="inxi -Ixxx"
alias net="inxi -Nxxx"
# Net
alias ports='netstat -tulanp'
alias ipinfo='curl ifconfig.me'
# Upgrade System
alias up="epm update && epm full-upgrade"
alias cc="sudo apt-get clean && sudo apt-get autoclean && sudo apt-get check && flatpak uninstall --unused -y && sudo journalctl --vacuum-time=1weeks"
alias update='sudo apt-get update && sudo apt-get -dist-upgrade -y'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
# PC
alias ls='ls —color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
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
