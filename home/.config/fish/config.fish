# Запускаем fastfetch только в интерактивных сессиях
if status is-interactive
    fastfetch
end

# Отключаем стандартное приветствие Fish при запуске терминала
set -gx fish_greeting ""

# Задаём nano как редактор по умолчанию
# Используется утилитами Git (git commit), crontab -e, visudo и др.
set -gx EDITOR nano
# Задаём nano как приоритетный редактор
set -gx VISUAL nano

# Steam
alias steamguard="/run/media/$USER/Work/Distrib/Linux/AppImage/steamguard"

# Просмотр файлов через bat
if type -q bat
    alias cat bat
end

# Git алиасы
alias add "git add ."
alias commit "git commit -m"
alias push "git push"
alias pull "git pull"
alias log "git log"
alias diff "git diff"
alias diffs "git diff --staged"
alias restore "git restore"
alias clone "git clone"
alias checkout "git checkout"
alias gs "git status"
alias gc "git commit -m"
alias gp "git push"
alias glo "git log --oneline --graph --all"
alias gco "git checkout"

# Логи системы
alias syslog "sudo dmesg --level=err,warn"

# YouTube (скачивание видео и аудио)
alias youtube 'yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 --output "%(title)s.%(ext)s"'
alias youtubemp3 'yt-dlp -x --audio-format mp3 --output "%(title)s_audio.%(ext)s"'

# Информация о системе через inxi
alias pc "inxi -Ixxx"
alias net "inxi -Nxxx"

# Сетевые команды
alias ports "netstat -tulanp"
alias ipinfo "curl ifconfig.me"

# Работа с конфигурационными файлами
alias fishrc "nano /home/$USER/.config/fish/config.fish"
alias fstab "sudo nano /etc/fstab"
alias bashrc "nano ~/.bashrc"
alias zshrc "nano ~/.zshrc"

# Управление GRUB
alias editgrub "sudo nano /etc/default/grub"
alias updategrub "sudo update-grub"
alias grubupdate "sudo update-grub"

# Файловые команды
alias ls "ls --color=auto"
alias ll "ls -alF"
alias la "ls -A"

# Если установлен lsd, используем его вместо ls
if type -q lsd
    alias l "lsd --date-format '+%d.%m.%Y %H:%M' -lah"
else
    alias l "ls -CF"
end

# Tools
# UV
if type -q uv
    uv generate-shell-completion fish | source
end

# Zoxide
if type -q zoxide
    zoxide init fish | source
end

# FZF
if type -q fzf
    fzf --fish | source
end
