# ============================================================
# Fastfetch
# ============================================================

if status is-interactive; and type -q fastfetch
    fastfetch
end

set -g fish_greeting ""                                           # Отключить приветствие Fish
set -gx EDITOR micro                                               # Редактор по умолчанию
set -gx VISUAL micro                                               # Редактор для визуальных операций


# ============================================================
# Скачивание видео и аудио через yt-dlp
# ============================================================

set target_dir /mnt/Work                                           # Основной каталог загрузок

if test -d "$target_dir"; and test -w "$target_dir"
    set -g YT_DOWNLOAD_DIR "$target_dir"                           # Использовать /mnt/Work
else
    set -g YT_DOWNLOAD_DIR "$HOME/Загрузки"                        # Запасной каталог
end

mkdir -p "$YT_DOWNLOAD_DIR"                                       # Создать каталог, если его нет

alias dl 'yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR/%(title)s.%(ext)s"'                 # Скачать видео
alias dlmp3 'yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR/%(title)s_audio.%(ext)s"'                         # Скачать аудио в MP3


# ============================================================
# Steam
# ============================================================

alias steamguard="/mnt/Work/Distrib/Linux/AppImage/steamguard"     # Запустить SteamGuard


# ============================================================
# Просмотр файлов через bat
# ============================================================

if type -q bat
    alias cat bat                                                 # Использовать bat вместо cat
else if type -q batcat
    alias cat batcat                                              # Использовать batcat вместо cat
end


# ============================================================
# Просмотр man-страниц через bat
# ============================================================

if type -q col
    if type -q bat
        set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"       # Показывать man через bat
    else if type -q batcat
        set -gx MANPAGER "sh -c 'col -bx | batcat -l man -p'"   # Показывать man через batcat
    end
end


# ============================================================
# Git-алиасы
# ============================================================

alias add="git add ."                                              # Добавить все изменения
alias commit="git commit -m"                                      # Создать коммит с сообщением
alias push="git push"                                              # Отправить изменения
alias pull="git pull"                                              # Получить изменения
alias log="git log --graph --all"                                  # Показать граф коммитов
alias diff="git diff"                                              # Показать изменения
alias diffs="git diff --staged"                                   # Показать подготовленные изменения
alias restore="git restore"                                       # Отменить изменения
alias clone="git clone"                                           # Клонировать репозиторий
alias checkout="git checkout"                                     # Переключить ветку

alias gs="git status"                                              # Статус репозитория
alias stat="git status"                                            # Статус репозитория
alias gc="git commit -m"                                           # Создать коммит
alias gp="git push"                                                # Отправить изменения
alias glo="git log --oneline --graph --all"                       # Краткий граф коммитов
alias gco="git checkout"                                           # Переключить ветку


# ============================================================
# Системные логи
# ============================================================

alias syslog "sudo dmesg --level=err,warn"                         # Показать ошибки и предупреждения ядра


# ============================================================
# Информация о системе через inxi
# ============================================================

alias pc "inxi -Ixxx"                                              # Информация о системе
alias net "inxi -Nxxx"                                             # Информация о сети


# ============================================================
# Сетевые команды
# ============================================================

if type -q ss
    alias ports "sudo ss -tulpen"                                 # Показать сетевые порты
else if type -q netstat
    alias ports "netstat -tulanp"                                 # Показать сетевые порты через netstat
end

if type -q curl
    alias ipinfo "curl -4 ifconfig.me"                            # Показать внешний IPv4-адрес
end


# ============================================================
# Управление пакетами Arch Linux
# ============================================================

alias mirror="sudo reflector --verbose --country 'Russia' -l 25 --sort rate --save /etc/pacman.d/mirrorlist"  # Обновить зеркала Arch
alias unlock="sudo rm /var/lib/pacman/db.lck"                     # Удалить блокировку pacman
alias clean="sudo pacman -Sc"                                     # Очистить кэш пакетов
alias info="sudo pacman -Qi"                                      # Информация о пакете


# ============================================================
# Управление пакетами Debian/Ubuntu
# ============================================================

alias up="sudo apt-get update && sudo apt-get dist-upgrade -y"     # Обновить систему

alias cc="sudo apt-get clean && \
sudo apt-get autoclean && \
sudo apt-get check && \
flatpak uninstall --unused -y && \
sudo journalctl --vacuum-time=1w"                                 # Очистить пакеты, Flatpak и старые логи

alias upgrade='sudo apt-get update && sudo apt-get dist-upgrade -y' # Обновить систему
alias install='sudo apt-get install'                              # Установить пакет
alias remove='sudo apt-get remove'                                # Удалить пакет


# ============================================================
# Работа с конфигурационными файлами
# ============================================================

alias fishrc "micro /home/$USER/.config/fish/config.fish"         # Открыть конфигурацию Fish
alias fstab "sudo micro /etc/fstab"                               # Открыть fstab
alias bashrc "micro ~/.bashrc"                                    # Открыть конфигурацию Bash
alias zshrc "micro ~/.zshrc"                                      # Открыть конфигурацию Zsh


# ============================================================
# Управление GRUB
# ============================================================

alias editgrub "sudo micro /etc/default/grub"                     # Открыть конфигурацию GRUB
alias updategrub "sudo update-grub"                               # Обновить конфигурацию GRUB
alias grubupdate "sudo update-grub"                               # Обновить конфигурацию GRUB


# ============================================================
# Файловые команды
# ============================================================

alias ls "ls --color=auto"                                        # Цветной вывод ls
alias ll "ls -alF"                                                # Подробный список файлов
alias la "ls -A"                                                  # Показать скрытые файлы

if type -q lsd
    alias l "lsd --date-format '+%d.%m.%Y %H:%M' -lah"             # Использовать lsd
else
    alias l "ls -CF"                                               # Использовать обычный ls
end


# ============================================================
# UV
# ============================================================

if type -q uv
    uv generate-shell-completion fish | source                     # Включить автодополнение UV
end


# ============================================================
# Zoxide
# ============================================================

if type -q zoxide
    zoxide init fish | source                                      # Инициализировать zoxide
end


# ============================================================
# GPG
# ============================================================

if status is-interactive; and isatty stdout
    set -gx GPG_TTY (tty)                                          # Указать терминал для GPG
end


# ============================================================
# Direnv
# ============================================================

if type -q direnv
    direnv hook fish | source                                      # Включить интеграцию direnv
end


# ============================================================
# FZF
# ============================================================

set -gx FZF_DEFAULT_OPTS \
    "--no-mouse \
    --height 80% \
    --border \
    --reverse \
    --multi \
    --info=inline \
    --preview-window='right:60%:wrap' \
    --bind='ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | xclip -selection clipboard),ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query'"  # Настройки интерфейса FZF

set -gx FZF_COMPLETION_OPTS "--border --info=inline"               # Настройки автодополнения FZF

if type -q fzf
    fzf --fish | source                                            # Включить интеграцию FZF с Fish
end


# ============================================================
# Go
# ============================================================

if type -q go
    set -l go_path (go env GOPATH 2>/dev/null)                    # Получить GOPATH

    if test -n "$go_path"
        set -l go_bin "$go_path/bin"                              # Каталог Go-программ
        mkdir -p "$go_bin"                                        # Создать каталог, если его нет
        fish_add_path "$go_bin"                                   # Добавить каталог в PATH
    end
end


# ============================================================
# fd для FZF
# ============================================================

if type -q fd
    function __fzf_compgen_path --description "Generate file paths using fd for FZF"
        set -l search_path "$argv[1]"                              # Путь для поиска

        if test -z "$search_path"
            set search_path .                                      # Использовать текущий каталог
        end

        command fd \
            --hidden \
            --follow \
            --exclude .git \
            --exclude node_modules \
            . "$search_path"                                       # Найти файлы через fd
    end

    function __fzf_compgen_dir --description "Generate directories using fd for FZF"
        set -l search_path "$argv[1]"                              # Путь для поиска

        if test -z "$search_path"
            set search_path .                                      # Использовать текущий каталог
        end

        command fd \
            --type d \
            --hidden \
            --follow \
            --exclude .git \
            --exclude node_modules \
            . "$search_path"                                       # Найти каталоги через fd
    end
else
    echo "fd не установлен. FZF будет использовать стандартный поиск." >/dev/null
end


# ============================================================
# libpq
# ============================================================

if test -d /usr/local/opt/libpq/bin
    fish_add_path /usr/local/opt/libpq/bin                       # Добавить libpq в PATH
end


# ============================================================
# Prompt
# ============================================================

function fish_prompt
    set -l last_status $status                                     # Сохранить код предыдущей команды

    set_color blue
    echo -n "┌─"

    set_color cyan
    echo -n (whoami)

    set_color white
    echo -n "@"

    set_color cyan
    echo -n (hostname -s)

    set_color yellow
    echo -n " "(date "+%H:%M:%S")                                   # Показать время

    set_color green
    echo -n " "(prompt_pwd)                                        # Показать текущий каталог

    if type -q fish_vcs_prompt
        set_color magenta
        echo -n (fish_vcs_prompt)                                  # Показать информацию Git
    end

    set_color normal
    echo

    if test $last_status -eq 0
        set_color blue
        echo -n "└─"

        set_color green
        echo -n "❯ "
    else
        set_color red
        echo -n "└─"

        set_color red
        echo -n "❯ "
    end

    set_color normal
end
