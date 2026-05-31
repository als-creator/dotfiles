# Запускаем fastfetch только в интерактивных сессиях
if status is-interactive
    fastfetch
end

# Отключаем стандартное приветствие Fish при запуске терминала
set -gx fish_greeting ""

# Задаём nano как редактор по умолчанию
# для Git (git commit), crontab -e, visudo и др.
set -gx EDITOR nano
# Задаём nano как приоритетный редактор
set -gx VISUAL nano

# Скачивание видео и аудио c видеохостингов
# Устанавливаем дефолтный путь для скачивания
set -l target_dir "/run/media/$USER/Work"

if test -d "$target_dir"
    set -gx YT_DOWNLOAD_DIR "$target_dir/"
else
    set -gx YT_DOWNLOAD_DIR "$HOME/Загрузки/"
    echo "Предупреждение: $target_dir не существует. Используем $HOME/Загрузки"
end
# Алиасы для скачивания
alias youtube='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR/%(title)s.%(ext)s"'
alias youtubemp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR/%(title)s_audio.%(ext)s"'
alias vk='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR/%(title)s.%(ext)s"'
alias vkmp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR/%(title)s_audio.%(ext)s"'
alias rutube='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR/%(title)s.%(ext)s"'
alias rutubemp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR/%(title)s_audio.%(ext)s"'

# Steam
alias steamguard="/run/media/$USER/Work/Distrib/Linux/AppImage/steamguard"

# Просмотр файлов через bat
if type -q bat
    alias cat bat
end

# Отображение man‑страниц через bat
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

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

# Информация о системе через inxi
alias pc "inxi -Ixxx"
alias net "inxi -Nxxx"

# Сетевые команды
alias ports "netstat -tulanp"
alias ipinfo "curl ifconfig.me"

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

# Сообщает GPG, какой терминал используется
set -gx GPG_TTY (tty)

# Проверяет, установлен ли direnv, и подключает хуки специфичным для fish синтаксисом
if type -q direnv
    direnv hook fish | source
end

# Настройки fzf для fish
# Основные опции FZF
set -gx FZF_DEFAULT_OPTS "--no-mouse --height 80% --border --reverse --multi --info=inline --preview-window='right:60%:wrap' --bind='ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | xclip -selection clipboard),ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query'"

# Настройки автодополнения FZF
set -gx FZF_COMPLETION_OPTS '--border --info=inline'

# Проверка установки fd (аналог find)
if type -q fd
    # Функция для генерации путей (аналог _fzf_compgen_path)
    function __fzf_compgen_path --description "Generate file paths using fd for FZF"
        command fd --hidden --follow --exclude .git --exclude node_modules . $argv[1]
    end

    # Функция для генерации директорий (аналог _fzf_compgen_dir)
    function __fzf_compgen_dir --description "Generate directories using fd for FZF"
        command fd --type d --hidden --follow --exclude .git --exclude node_modules . $argv[1]
    end

    # Регистрируем функции для использования с FZF
    set -g __FZF_COMPGEN_PATH_COMMAND __fzf_compgen_path
    set -g __FZF_COMPGEN_DIR_COMMAND __fzf_compgen_dir
else
    echo "fd не установлен. FZF будет использовать стандартные команды поиска." >/dev/null
end

# Инициализация FZF для Fish
if type -q fzf
    fzf --fish | source
end

# Настройки для go, проверка установки и путей
# Безопасная настройка путей для Go — проверяем установку Go перед работой с путями
if type -q go
    # Получаем GOPATH через go env
    set -l go_gopath (go env GOPATH)

    # Проверяем, что GOPATH не пустой и директория существует
    if test -n "$go_gopath" && test -d "$go_gopath"
        if not contains "$go_gopath/bin" $PATH
            set -p PATH "$go_gopath/bin"
        end
    else
        # Если GOPATH не задан или директория не существует, создаём стандартную
        set -l default_gopath $HOME/.go
        if not test -d "$default_gopath"
            mkdir -p "$default_gopath"
        end
        set -gx GOPATH "$default_gopath"
        if not contains "$default_gopath/bin" $PATH
            set -p PATH "$default_gopath/bin"
        end
    end

    # Добавляем GOROOT/bin, если GOROOT задан
    set -l go_goroot (go env GOROOT)
    if test -n "$go_goroot" && test -d "$go_goroot/bin"
        if not contains "$go_goroot/bin" $PATH
            set -p PATH "$go_goroot/bin"
        end
    end
else
    echo "Go не установлен. Пропускаем настройку путей для Go." >/dev/null
end

# Безопасная проверка и добавление libpq в PATH
if test -d /usr/local/opt/libpq/bin
    if not contains /usr/local/opt/libpq/bin $PATH
        set -p PATH /usr/local/opt/libpq/bin
    end
else
    echo "libpq не установлен или путь /usr/local/opt/libpq/bin не существует. Пропускаем." >/dev/null
end
