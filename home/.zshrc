# Запускаем fastfetch только в интерактивных сессиях
if [[ -o interactive ]]; then
    fastfetch
fi

# Задаём nano как редактор по умолчанию
# для Git (git commit), crontab -e, visudo и др.
export EDITOR=nano
# Задаём nano как приоритетный редактор
export VISUAL=nano

# Скачивание видео и аудио c видеохостингов
# Устанавливаем дефолтный путь для скачивания
target_dir="/run/media/$USER/Work"

if [[ -d "$target_dir" ]]; then
    export YT_DOWNLOAD_DIR="$target_dir"
else
    export YT_DOWNLOAD_DIR="$HOME/Загрузки"
    echo "Предупреждение: $target_dir не существует. Используем $HOME/Загрузки"
fi

alias youtube='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR%(title)s.%(ext)s"'
alias youtubemp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR%(title)s_audio.%(ext)s"'
alias vk='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR%(title)s.%(ext)s"'
alias vkmp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR%(title)s_audio.%(ext)s"'
alias rutube='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR%(title)s.%(ext)s"'
alias rutubemp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR%(title)s_audio.%(ext)s"'

# Steam
alias steamguard="/run/media/$USER/Work/Distrib/Linux/AppImage/steamguard"

# Просмотр файлов через bat
if command -v bat &>/dev/null; then
    alias cat=bat
fi

# Отображение man‑страниц через bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Git алиасы
alias add="git add ."
alias commit="git commit -m"
alias push="git push"
alias pull="git pull"
alias log="git log"
alias diff="git diff"
alias diffs="git diff --staged"
alias restore="git restore"
alias clone="git clone"
alias checkout="git checkout"
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"
alias glo="git log --oneline --graph --all"
alias gco="git checkout"

# Логи системы
alias syslog="sudo dmesg --level=err,warn"

# Информация о системе через inxi
alias pc="inxi -Ixxx"
alias net="inxi -Nxxx"

# Сетевые команды
alias ports="netstat -tulanp"
alias ipinfo="curl ifconfig.me"

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

# Работа с конфигурационными файлами
alias fishrc="nano /home/$USER/.config/fish/config.fish"
alias fstab="sudo nano /etc/fstab"
alias bashrc="nano ~/.bashrc"
alias zshrc="nano ~/.zshrc"

# Управление GRUB
alias editgrub="sudo nano /etc/default/grub"
alias updategrub="sudo update-grub"
alias grubupdate="sudo update-grub"

# Файловые команды
alias ls="ls --color=auto"
alias ll="ls -alF"
alias la="ls -A"

# Если установлен lsd, используем его вместо ls
if command -v lsd &>/dev/null; then
    alias l="lsd --date-format '+%d.%m.%Y %H:%M' -lah"
else
    alias l="ls -CF"
fi

# Tools
# UV
if command -v uv &>/dev/null; then
    eval "$(uv generate-shell-completion zsh)"
fi

# Zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# Сообщает GPG, какой терминал используется
export GPG_TTY=$(tty)

# Проверяет, установлен ли direnv, и подключает хуки
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# Настройки fzf для zsh
# Основные опции FZF
export FZF_DEFAULT_OPTS="--no-mouse --height 80% --border --reverse --multi --info=inline --preview-window='right:60%:wrap' --bind='ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | xclip -selection clipboard),ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query'"

# Настройки автодополнения FZF
export FZF_COMPLETION_OPTS='--border --info=inline'

# Проверка установки fd (аналог find)
if command -v fd &>/dev/null; then
    # Функция для генерации путей (аналог _fzf_compgen_path)
    __fzf_compgen_path() {
        command fd --hidden --follow --exclude .git --exclude node_modules . "$1"
    }

    # Функция для генерации директорий (аналог _fzf_compgen_dir)
    __fzf_compgen_dir() {
        command fd --type d --hidden --follow --exclude .git --exclude node_modules . "$1"
    }

    # Регистрируем функции для использования с FZF
    export __FZF_COMPGEN_PATH_COMMAND=__fzf_compgen_path
    export __FZF_COMPGEN_DIR_COMMAND=__fzf_compgen_dir
else
    echo "fd не установлен. FZF будет использовать стандартные команды поиска." >/dev/null
fi

# Инициализация FZF для zsh
if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
fi

# Настройки для Go, проверка установки и путей
# Безопасная настройка путей для Go — проверяем установку Go перед работой с путями
if command -v go &>/dev/null; then
    # Получаем GOPATH через go env
    go_gopath=$(go env GOPATH)

    # Проверяем, что GOPATH не пустой и директория существует
    if [[ -n "$go_gopath" && -d "$go_gopath" ]]; then
        if [[ ":$PATH:" != *":$go_gopath/bin:"* ]]; then
            export PATH="$go_gopath/bin:$PATH"
        fi
    else
        # Если GOPATH не задан или директория не существует, создаём стандартную
        default_gopath="$HOME/.go"
        if [[ ! -d "$default_gopath" ]]; then
            mkdir -p "$default_gopath"
        fi
        export GOPATH="$default_gopath"
        if [[ ":$PATH:" != *":$default_gopath/bin:"* ]]; then
            export PATH="$default_gopath/bin:$PATH"
        fi
    fi

    # Добавляем GOROOT/bin, если GOROOT задан
    go_goroot=$(go env GOROOT)
    if [[ -n "$go_goroot" && -d "$go_goroot/bin" ]]; then
        if [[ ":$PATH:" != *":$go_goroot/bin:"* ]]; then
            export PATH="$go_goroot/bin:$PATH"
        fi
    fi

    # Устанавливаем GOBIN, если он не задан
    if [[ -z "$GOBIN" ]]; then
        export GOBIN="$GOPATH/bin"
    fi

    # Дополнительные переменные окружения для Go
    export GOCACHE="$HOME/.cache/go-build"
    export GO111MODULE=on

    # Создаём стандартные директории внутри GOPATH
    mkdir -p "$GOPATH"/{bin,pkg,src}

    echo "Go настроен: GOPATH=$GOPATH, GOROOT=$go_goroot"
else
    echo "Go не установлен. Пропускаем настройку путей для Go." >/dev/null
fi

