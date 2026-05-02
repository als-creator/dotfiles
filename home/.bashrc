# Редактор по умолчанию для утилит (Git, crontab и др.)
export EDITOR=nano
export VISUAL=nano

# Алиас для Steam Guard
alias steamguard="/run/media/$USER/Work/Distrib/Linux/AppImage/steamguard"

# Включаем автодополнение команд (если установлено)
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Настройки истории команд
HISTSIZE=10000          # Количество команд, хранящихся в памяти
SAVEHIST=10000         # Количество команд для сохранения в файл истории
HISTFILE=~/.bash_history # Файл, в котором сохраняется история команд
HISTCONTROL=ignoreboth  # Игнорировать дубликаты и команды с пробелом в начале


# Опции истории команд
shopt -s histappend      # Добавлять историю вместо перезаписи
shopt -s cmdhist       # Сохранять многострочные команды как одну запись
shopt -s lithist       # Сохранять команды с комментариями

# Настройка формата времени в истории
HISTTIMEFORMAT='%F %T ' # Формат: ГГГГ-ММ-ДД ЧЧ:ММ:СС

# Настройка приглашения командной строки (prompt)
# \u — пользователь, \h — хост, \W — текущая директория, \$ — приглашение ($ или #)
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\] \$ '

# Функция для перехода в директорию с одновременным выводом её содержимого
cdls() {
  cd "$@" && ls -la --color=auto
}
# Алиас для функции cdls (не переопределяет стандартную команду cd)
alias cdl="cdls"

# Алиасы для работы с Git
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
alias glo='git log --oneline --graph --all'
alias gco='git checkout'

# Алиасы для просмотра системных логов
alias syslog="sudo dmesg --level=err,warn"

# Алиасы для скачивания видео и аудио с YouTube
alias youtube='yt-dlp -f "bestvideo[height<=1080]+bestaudio" --merge-output-format mp4 --output "%(title)s.%(ext)s"'
alias youtubemp3='yt-dlp -x --audio-format mp3 --output "%(title)s_audio.%(ext)s"'

# Алиасы для получения информации о системе через inxi
alias pc="inxi -Ixxx"
alias net="inxi -Nxxx"

# Сетевые алиасы
alias ports='netstat -tulanp'
alias ipinfo='curl ifconfig.me'

# Алиасы для управления пакетами в Arch Linux
alias mirror="sudo reflector --verbose --country 'Russia' -l 25 --sort rate --save /etc/pacman.d/mirrorlist"
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias clean="sudo pacman -Sc"
alias info="sudo pacman -Qi"


# Алиасы для управления пакетами в Debian/Ubuntu
alias up="sudo apt-get update && sudo apt-get dist-upgrade -y"
alias cc="sudo apt-get clean && sudo apt-get autoclean && sudo apt-get check && flatpak uninstall --unused -y && sudo journalctl --vacuum-time=1w"
alias upgrade='sudo apt-get update && sudo apt-get dist-upgrade -y'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'

# Файловые алиасы
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Алиасы для редактирования конфигурационных файлов
alias fishrc="nano /home/$USER/.config/fish/config.fish"
alias fstab="sudo nano /etc/fstab"
alias bashrc="nano ~/.bashrc"
alias zshrc="nano ~/.zshrc"

# Алиасы для настройки GRUB
alias editgrub="sudo nano /etc/default/grub"
alias updategrub="sudo update-grub"
alias grubupdate="sudo update-grub"

# Улучшенное автодополнение для Git (если установлено)
if type __git_complete &>/dev/null; then
  __git_complete gc git-commit
  __git_complete glo git-log
  __git_complete gco git-checkout
  __git_complete gp git-push
  __git_complete gs git-status
fi

# Подсветка синтаксиса в командной строке через bash-preexec (если установлено)
if [ -f ~/.bash-preexec.sh ]; then
  source ~/.bash-preexec.sh
fi
