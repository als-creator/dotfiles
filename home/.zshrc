# ============================================================
# Базовый PATH
# ============================================================

typeset -U path PATH

path=(
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin
    "$path[@]"
)

export PATH

# ============================================================
# HISTORY
# ============================================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt INC_APPEND_HISTORY    # Записывать команды в файл сразу после выполнения
setopt HIST_IGNORE_DUPS      # Не сохранять одинаковые команды подряд
setopt HIST_IGNORE_ALL_DUPS  # Удалять предыдущие копии повторяющейся команды
setopt HIST_IGNORE_SPACE     # Не сохранять команды, начинающиеся с пробела
setopt HIST_SAVE_NO_DUPS     # Не сохранять дубликаты при записи истории
setopt HIST_REDUCE_BLANKS    # Убирать лишние пробелы из команд

HISTORY_IGNORE='(ls|cd|pwd|exit)(|[[:space:]]*)'  # Не сохранять ls, cd, pwd и exit

# ============================================================
# Fastfetch
# ============================================================

if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

# ============================================================
# Редактор по умолчанию
# ============================================================

export EDITOR=micro
export VISUAL=micro

# ============================================================
# Скачивание видео и аудио через yt-dlp
# ============================================================

target_dir="/mnt/Work"                                             # Основной каталог загрузок

if [[ -d "$target_dir" && -w "$target_dir" ]]; then
    YT_DOWNLOAD_DIR="$target_dir"                                  # Использовать /mnt/Work
else
    YT_DOWNLOAD_DIR="$HOME/Загрузки"                               # Запасной каталог
fi

mkdir -p "$YT_DOWNLOAD_DIR"                                       # Создать каталог, если его нет

alias dl='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR/%(title)s.%(ext)s"'                 # Скачать видео
alias dlmp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR/%(title)s_audio.%(ext)s"'                         # Скачать аудио в MP3


# ============================================================
# Steam
# ============================================================

alias steamguard="/mnt/Work/Distrib/Linux/AppImage/steamguard"

# ============================================================
# Просмотр файлов через bat
# ============================================================

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never --style=plain'
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else
    export MANPAGER='less -R'
fi

# ============================================================
# Автодополнение zsh
# ============================================================

autoload -Uz compinit
compinit -d "$HOME/.zcompdump"

# ============================================================
# Git-алиасы
# ============================================================

alias add="git add ."
alias commit="git commit -m"
alias push="git push"
alias pull="git pull"
alias log="git log --graph --all"
alias diff="git diff"
alias diffs="git diff --staged"
alias restore="git restore"
alias clone="git clone"
alias checkout="git checkout"

alias gs="git status"
alias stat="git status"
alias gc="git commit -m"
alias gp="git push"
alias glo="git log --oneline --graph --all"
alias gco="git checkout"

# ============================================================
# Системные логи
# ============================================================

alias syslog="sudo dmesg --level=err,warn"

# ============================================================
# Информация о системе через inxi
# ============================================================

alias pc="inxi -Ixxx"
alias net="inxi -Nxxx"

# ============================================================
# Сетевые команды
# ============================================================

alias ports="sudo ss -tulpn"
alias ipinfo="curl -4 https://ifconfig.me"

# ============================================================
# Управление пакетами Arch Linux
# ============================================================

alias mirror="sudo reflector --verbose --country Russia --latest 25 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias clean="sudo pacman -Sc"
alias info="sudo pacman -Qi"

# ============================================================
# Управление пакетами Debian/Ubuntu
# ============================================================

alias up="sudo apt-get update && sudo apt-get dist-upgrade -y"
alias cc="sudo apt-get clean && sudo apt-get autoclean && sudo apt-get check && flatpak uninstall --unused -y && sudo journalctl --vacuum-time=1w"
alias upgrade="sudo apt-get update && sudo apt-get dist-upgrade -y"
alias install="sudo apt-get install"
alias remove="sudo apt-get remove"

# ============================================================
# Работа с конфигурационными файлами
# ============================================================

alias fishrc="micro ~/.config/fish/config.fish"
alias fstab="sudo micro /etc/fstab"
alias bashrc="micro ~/.bashrc"
alias zshrc="micro ~/.zshrc"

# ============================================================
# Управление GRUB
# ============================================================

alias editgrub="sudo micro /etc/default/grub"
alias updategrub="sudo update-grub"
alias grubupdate="sudo update-grub"

# ============================================================
# Файловые команды
# ============================================================

alias ls="ls --color=auto"
alias ll="ls -alF"
alias la="ls -A"

if command -v lsd >/dev/null 2>&1; then
    alias l="lsd --date-format '+%d.%m.%Y %H:%M' -lah"
else
    alias l="ls -CF"
fi

# ============================================================
# UV
# ============================================================

if command -v uv >/dev/null 2>&1; then
    eval "$(uv generate-shell-completion zsh)"
fi

# ============================================================
# Zoxide
# ============================================================

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# ============================================================
# GPG
# ============================================================

if [[ -t 0 ]]; then
    export GPG_TTY="$(tty)"
fi

# ============================================================
# Direnv
# ============================================================

if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# ============================================================
# FZF
# ============================================================

if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)

    export FZF_DEFAULT_OPTS="--no-mouse \
    --height 80% \
    --border \
    --reverse \
    --multi \
    --info=inline \
    --preview-window='right:60%:wrap' \
    --bind='ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | xclip -selection clipboard),ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query'"

    export FZF_COMPLETION_OPTS="--border --info=inline"
fi

# ============================================================
# fd для FZF
# ============================================================

if command -v fd >/dev/null 2>&1; then
    __fzf_compgen_path() { fd --hidden --follow --exclude .git --exclude node_modules . "$1" }
    __fzf_compgen_dir() { fd --type d --hidden --follow --exclude .git --exclude node_modules . "$1" }
    export __FZF_COMPGEN_PATH_COMMAND=__fzf_compgen_path
    export __FZF_COMPGEN_DIR_COMMAND=__fzf_compgen_dir
fi

# ============================================================
# Go
# ============================================================

if (( $+commands[go] )); then
    export GOPATH="${GOPATH:-$HOME/go}"

    typeset -U path
    path=("$GOPATH/bin" $path)
fi


# ============================================================
# Приглашение строки ввода
# ============================================================

autoload -Uz colors && colors
setopt prompt_subst
bindkey -e

LINE1='%F{blue}┌─%f%F{cyan}%n%f%F{white}@%f%F{cyan}%m%f %F{yellow}%D{%H:%M:%S}%f %F{green}%~%f'
LINE2='%F{blue}└─%f%(?.%F{green}.%F{red})❯%f '
PROMPT='${LINE1}
${LINE2}'
RPROMPT=''

# ============================================================
# Дополнительные настройки ZSH
# ============================================================

zstyle ':completion:*' menu select                                      # Меню автодополнения со стрелками
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'              # Игнорировать регистр при автодополнении
setopt autocd                                                          # Переходить в каталог без команды cd
export KEYTIMEOUT=20                                                   # Задержка распознавания специальных клавиш
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=34;42'  # Цвета ls
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}          # Цвета вариантов автодополнения

