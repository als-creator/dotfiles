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

if command -v yt-dlp >/dev/null 2>&1; then
    target_dir="/mnt/Work"                                             # Основной каталог загрузок

    if [[ -d "$target_dir" && -w "$target_dir" ]]; then
        YT_DOWNLOAD_DIR="$target_dir"                                  # Использовать /mnt/Work
    else
        YT_DOWNLOAD_DIR="$HOME/Загрузки"                               # Запасной каталог
    fi

    mkdir -p "$YT_DOWNLOAD_DIR"                                       # Создать каталог, если его нет

    alias dl='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR/%(title)s.%(ext)s"'                 # Скачать видео
    alias dlmp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR/%(title)s_audio.%(ext)s"'                         # Скачать аудио в MP3
fi


# ============================================================
# Steam
# ============================================================

if [[ -x "/mnt/Work/Distrib/Linux/AppImage/steamguard" ]]; then
    alias steamguard="/mnt/Work/Distrib/Linux/AppImage/steamguard"
fi

# ============================================================
# Просмотр файлов через bat
# ============================================================

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never --style=plain'
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif command -v batcat >/dev/null 2>&1; then
    alias cat='batcat --paging=never --style=plain'
    export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
else
    export MANPAGER='less -R'
fi

# ============================================================
# Автодополнение zsh
# ============================================================

plugins_dir="$HOME/.local/share/zsh/plugins"

# zsh-completions - расширенные дополнения
if [[ -d "$plugins_dir/zsh-completions" ]]; then
    fpath+=("$plugins_dir/zsh-completions/src")
fi

autoload -Uz compinit && compinit

# zsh-autosuggestions - серые подсказки из истории (как в fish)
if [[ -f "$plugins_dir/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$plugins_dir/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"
fi

# Стрелки вверх/вниз ищут историю по уже набранному тексту (как в fish)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# zsh-syntax-highlighting - подсветка синтаксиса (должен быть последним)
if [[ -f "$plugins_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$plugins_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

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
alias glo="git log --oneline --graph --decorate --all"
alias gco="git checkout"

# ============================================================
# Системные логи
# ============================================================

alias syslog="sudo dmesg --level=err,warn"

# ============================================================
# Информация о системе через inxi
# ============================================================

if command -v inxi >/dev/null 2>&1; then
    alias pc="inxi -Ixxx"
    alias net="inxi -Nxxx"
fi

# ============================================================
# Сетевые команды
# ============================================================

if command -v ss >/dev/null 2>&1; then
    alias ports="sudo ss -tulpen"
elif command -v netstat >/dev/null 2>&1; then
    alias ports="netstat -tulanp"
fi

alias ipinfo="curl -4 https://ifconfig.me"

# ============================================================
# Управление пакетами Arch Linux
# ============================================================

alias mirror="sudo reflector --verbose --country 'Russia' --latest 25 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

unlock() {
    if pgrep -x pacman >/dev/null || \
       pgrep -x yay >/dev/null || \
       pgrep -x paru >/dev/null; then
        echo "Менеджер пакетов ещё запущен."
        return 1
    fi

    if [[ -e /var/lib/pacman/db.lck ]]; then
        sudo rm -i /var/lib/pacman/db.lck
    else
        echo "Файл /var/lib/pacman/db.lck не найден."
    fi
}
alias clean='sudo pacman -Sc --noconfirm && sudo find /var/cache/pacman/pkg/ -mindepth 1 -maxdepth 1 -type d -name "download-*" -print -exec rm -rf -- {} +'
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

# Для Arch Linux
alias grubconfig="sudo grub-mkconfig -o /boot/grub/grub.cfg"

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
    --bind='ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query'"

    if command -v wl-copy >/dev/null 2>&1; then
        export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --bind='ctrl-y:execute-silent(echo {+} | wl-copy)'"
    elif command -v xclip >/dev/null 2>&1; then
        export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --bind='ctrl-y:execute-silent(echo {+} | xclip -selection clipboard)'"
    fi

    export FZF_COMPLETION_OPTS="--border --info=inline"
fi

# ============================================================
# fd для FZF — актуальный API fzf (walker), как в bash:
# FZF_COMPLETION_PATH_OPTS / FZF_COMPLETION_DIR_OPTS
# ============================================================

if command -v fd >/dev/null 2>&1; then
    export FZF_COMPLETION_PATH_OPTS='--walker=file,dir,follow,hidden'
    export FZF_COMPLETION_DIR_OPTS='--walker=dir,follow,hidden'
fi

# ============================================================
# Go
# ============================================================

if (( $+commands[go] )); then
    export GOPATH="${GOPATH:-$HOME/go}"
    export GOBIN="${GOBIN:-$GOPATH/bin}"
    export GOCACHE="${GOCACHE:-$HOME/.cache/go-build}"

    mkdir -p "$GOBIN"

    typeset -U path
    path=("$GOBIN" $path)
fi


# ============================================================
# Приглашение строки ввода
# ============================================================

autoload -Uz colors && colors
autoload -Uz vcs_info
setopt prompt_subst
bindkey -e

zstyle ':vcs_info:git:*' formats ' %F{magenta}%b%f'
zstyle ':vcs_info:git:*' actionformats ' %F{magenta}%b%f %F{red}(%a)%f'
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }

LINE1='%F{blue}┌─%f%F{cyan}%n%f%F{white}@%f%F{cyan}%m%f %F{yellow}%D{%H:%M:%S}%f %F{green}%~%f${vcs_info_msg_0_}'
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

# ============================================================
# AI-агенты (как в omarchy: opencode + herdr)
# ============================================================

if command -v opencode >/dev/null 2>&1; then
    alias ai='opencode'          # Запустить AI-агента в текущем терминале
fi

if command -v herdr >/dev/null 2>&1; then
    alias agent='herdr'          # Менеджер агентов (как Super+Ctrl+Return)
fi

# ============================================================
# Навигация: .. ... .... mkcd d
# ============================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

mkcd() { mkdir -p -- "$1" && cd -- "$1"; }          # Создать каталог и перейти в него

alias d='dirs -v'                                   # Список каталогов-закладок

# ============================================================
# Буфер обмена: c (копия), p (вставка), copypath
# ============================================================

if command -v wl-copy >/dev/null 2>&1; then
    c() { printf '%s' "$*" | wl-copy; }             # Wayland
    p() { wl-paste; }
elif command -v xclip >/dev/null 2>&1; then
    c() { printf '%s' "$*" | xclip -selection clipboard; }   # X11
    p() { xclip -o -selection clipboard; }
fi

copypath() { command pwd | c; }                     # Скопировать текущий путь

# ============================================================
# Безопасное удаление: rm -I и корзина (trash)
# ============================================================

alias rm='rm -I'
if command -v gio >/dev/null 2>&1; then
    alias trash='gio trash'
fi

# ============================================================
# sysup — обновление всего одной командой
# ============================================================

sysup() {
    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -Syu --noconfirm
    fi
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update && sudo apt-get dist-upgrade -y
    fi
    if command -v flatpak >/dev/null 2>&1; then
        flatpak update -y
        flatpak uninstall --unused -y
    fi
}

# ============================================================
# fzf: ff (открыть файл), fcd (перейти в каталог)
# Ctrl+T / Alt+C уже задаются fzf --zsh
# ============================================================

if command -v fzf >/dev/null 2>&1 && command -v fd >/dev/null 2>&1; then
    ff() {
        local file
        file="$(fd --hidden --follow --exclude .git --exclude node_modules | fzf --preview 'bat --color=always --style=plain {} 2>/dev/null || cat {}')"
        [[ -n "$file" ]] && "${EDITOR:-micro}" "$file"
    }
    fcd() {
        local dir
        dir="$(fd --type d --hidden --follow --exclude .git --exclude node_modules | fzf)"
        [[ -n "$dir" ]] && cd "$dir"
    }
fi

# ============================================================
# grep/less и поиск по истории (h)
# ============================================================

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias less='less -R'

alias h='fc -l 1 | grep -i'                          # Поиск по истории

