if status is-interactive
    # Commands to run in interactive sessions can go here
end

fastfetch
set fish_greeting
set -gx EDITOR micro
set -gx VISUAL micro
alias pac="sudo pacman -S"
alias pacs="sudo pacman -Ss"
alias pacu="sudo pacman -Syy"
alias update="sudo pacman -Syyu"
alias mirrors="sudo reflector --verbose --country 'Russia' -l 25 --sort rate --save /etc/pacman.d/mirrorlist"
alias upgrade="sudo reflector --verbose --country 'Russia' -l 25 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu"
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias clean="sudo pacman -Scc"
alias remove="sudo pacman -R"
alias info="sudo pacman -Qi"
alias aur="yay -S"
alias aurno="yay -S --noconfirm"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gs="git status"
alias gp="git push"
alias gpl="git pull"
alias gl="git log"
alias glo="git log --oneline"
alias gd="git diff"
alias gds="git diff --staged"
alias gr="git restore"
alias syslog_emerg="sudo dmesg --level=emerg,alert,crit"
alias syslog="sudo dmesg --level=err,warn"
alias xlog='grep "(EE)\|(WW)\|error\|failed" ~/.local/share/xorg/Xorg.0.log'
alias vacuum="sudo journalctl --vacuum-size=100M"
alias vacuum_time="sudo journalctl --vacuum-time=2weeks"
alias rm="rmtrash "
alias youtube='yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 --output "%(title)s.%(ext)s"'
alias youtubemp3='yt-dlp -x --audio-format mp3 --output "%(title)s_audio.%(ext)s"'
uv generate-shell-completion fish | source
