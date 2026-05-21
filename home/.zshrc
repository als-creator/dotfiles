# Редактор по умолчанию для утилит (Git, crontab и др.)
export EDITOR=nano
export VISUAL=nano

# Алиас для Steam Guard
alias steamguard="/run/media/$USER/Work/Distrib/Linux/AppImage/steamguard"

# Включаем автодополнение команд
autoload -Uz compinit
compinit

# Настройки истории команд
HISTSIZE=10000          # Количество команд, хранящихся в памяти
SAVEHIST=10000         # Количество команд для сохранения в файл истории
HISTFILE=~/.zsh_history # Файл, в котором сохраняется история команд

# Опции истории команд
setopt EXTENDEDHISTORY    # Сохранять дату и время выполнения команд
setopt HIST_IGNORE_DUPS # Не показывать дубликаты команд в истории
setopt HIST_SAVE_NO_DUPS # Не сохранять дубликаты в файл истории
setopt HIST_REDUCE_BLANKS # Убирать лишние пробелы в записях истории

# Автодополнение с игнорированием регистра букв
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Дополнительные опции автодополнения и удобства работы
setopt AUTO_CD           # Автоматический переход в директорию при вводе её имени
setopt CORRECT         # Автокоррекция опечаток в командах
setopt CORRECT_ALL    # Автокоррекция аргументов команд

# Подсветка синтаксиса в командной строке (при наличии плагина)
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Настройка приглашения командной строки (prompt)
# Цвета: %F{цвет}, сброс цвета: %f, жирный текст: %B, сброс жирного: %b
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f %# '

# Функция для перехода в директорию с одновременным выводом её содержимого
function cdls() {
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

# Скачивание видео и аудио c youtube, vk, rutube, нужен firefox
alias youtube='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "%(title)s.%(ext)s"'
alias youtubemp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "%(title)s_audio.%(ext)s"'
alias vk='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "%(title)s.%(ext)s"'
alias vkmp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "%(title)s_audio.%(ext)s"'
alias rutube='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "%(title)s.%(ext)s"'
alias rutubemp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "%(title)s_audio.%(ext)s"'

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

# Инициализация UV (генератор автодополнений)
eval "$(uv generate-shell-completion zsh)" 2>/dev/null

# Инициализация Zoxide (умный переход между директориями)
eval "$(zoxide init zsh)" 2>/dev/null

# Подключение FZF (расширенное автодополнение и поиск)
source /usr/share/fzf/key-bindings.zsh 2>/dev/null
source /usr/share/fzf/completion.zsh 2>/dev/null
