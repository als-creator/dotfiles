# ============================================================
# Базовый PATH
# ============================================================

path_prepend() {
    case ":$PATH:" in
        *:"$1":*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

path_prepend /usr/local/sbin
path_prepend /usr/local/bin
path_prepend /usr/sbin
path_prepend /usr/bin
path_prepend /sbin
path_prepend /bin

export PATH


# ============================================================
# HISTORY
# ============================================================

HISTFILE="$HOME/.bash_history"
HISTSIZE=100000
HISTFILESIZE=100000

# Игнорировать команды, начинающиеся с пробела,
# и одинаковые команды подряд
HISTCONTROL=ignoreboth

# Не сохранять часто используемые команды
HISTIGNORE='ls:ls *:ll:ll *:la:la *:cd:cd *:pwd:exit:clear'

shopt -s histappend
shopt -s cmdhist
shopt -s lithist


# ============================================================
# Fastfetch
# ============================================================

if [[ $- == *i* ]] && command -v fastfetch >/dev/null 2>&1; then
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

target_dir="/mnt/Work"

if [[ -d "$target_dir" && -w "$target_dir" ]]; then
    YT_DOWNLOAD_DIR="$target_dir"
else
    YT_DOWNLOAD_DIR="$HOME/Загрузки"
fi

if [[ ! -d "$YT_DOWNLOAD_DIR" ]]; then
    mkdir -p "$YT_DOWNLOAD_DIR" 2>/dev/null
fi

if command -v yt-dlp >/dev/null 2>&1; then
    alias dl='yt-dlp --cookies-from-browser firefox -f "bestvideo+bestaudio/best" --merge-output-format mp4 --output "$YT_DOWNLOAD_DIR/%(title)s.%(ext)s"'

    alias dlmp3='yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --output "$YT_DOWNLOAD_DIR/%(title)s_audio.%(ext)s"'
fi


# ============================================================
# Steam
# ============================================================

if [[ -x "/mnt/Work/Distrib/Linux/AppImage/steamguard" ]]; then
    alias steamguard="/mnt/Work/Distrib/Linux/AppImage/steamguard"
fi


# ============================================================
# bat
# ============================================================

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never --style=plain'

    if command -v col >/dev/null 2>&1; then
        export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    else
        export MANPAGER='bat -l man -p'
    fi
elif command -v batcat >/dev/null 2>&1; then
    alias cat='batcat --paging=never --style=plain'

    if command -v col >/dev/null 2>&1; then
        export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
    else
        export MANPAGER='batcat -l man -p'
    fi
else
    export MANPAGER='less -R'
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
# Информация о системе
# ============================================================

if command -v inxi >/dev/null 2>&1; then
    alias pc="inxi -Ixxx"
    alias net="inxi -Nxxx"
fi


# ============================================================
# Сетевые команды
# ============================================================

alias ports="sudo ss -tulpen"

if ! command -v ss >/dev/null 2>&1 && command -v netstat >/dev/null 2>&1; then
    alias ports="netstat -tulanp"
fi

alias ipinfo="curl -4 https://ifconfig.me"


# ============================================================
# Arch Linux
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

alias clean='sudo pacman -Sc --noconfirm && sudo find /var/cache/pacman/pkg/ -mindepth 1 -maxdepth 1 -type d -name "download-*" -print -exec rm -rf -- {} + && rm -rf ~/.cache/yandex-browser'
alias info="sudo pacman -Qi"


# ============================================================
# Debian / Ubuntu
# ============================================================

alias up="sudo apt-get update && sudo apt-get dist-upgrade -y"

alias cc="sudo apt-get clean && \
sudo apt-get autoclean && \
sudo apt-get check && \
flatpak uninstall --unused -y && \
sudo journalctl --vacuum-time=1w"

alias upgrade="sudo apt-get update && sudo apt-get dist-upgrade -y"
alias install="sudo apt-get install"
alias remove="sudo apt-get remove"


# ============================================================
# Конфигурационные файлы
# ============================================================

alias fishrc="micro ~/.config/fish/config.fish"
alias fstab="sudo micro /etc/fstab"
alias bashrc="micro ~/.bashrc"
alias zshrc="micro ~/.zshrc"


# ============================================================
# GRUB
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
    eval "$(uv generate-shell-completion bash)"
fi


# ============================================================
# Zoxide
# ============================================================

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
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
    eval "$(direnv hook bash)"
fi


# ============================================================
# FZF
# ============================================================

export FZF_DEFAULT_OPTS="--no-mouse \
--height 80% \
--border \
--reverse \
--multi \
--info=inline \
--preview-window='right:60%:wrap' \
--bind='ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query'"

if command -v wl-copy >/dev/null 2>&1; then
    FZF_DEFAULT_OPTS+=" --bind='ctrl-y:execute-silent(echo {+} | wl-copy)'"
elif command -v xclip >/dev/null 2>&1; then
    FZF_DEFAULT_OPTS+=" --bind='ctrl-y:execute-silent(echo {+} | xclip -selection clipboard)'"
fi

export FZF_COMPLETION_OPTS="--border --info=inline"

if command -v fd >/dev/null 2>&1; then
    export FZF_COMPLETION_PATH_OPTS='--walker=file,dir,follow,hidden'
    export FZF_COMPLETION_DIR_OPTS='--walker=dir,follow,hidden'
fi

if command -v fzf >/dev/null 2>&1; then
    source <(fzf --bash)
fi


# ============================================================
# Go
# ============================================================

if command -v go >/dev/null 2>&1; then
    export GOPATH="${GOPATH:-$HOME/go}"
    export GOBIN="${GOBIN:-$GOPATH/bin}"
    export GOCACHE="${GOCACHE:-$HOME/.cache/go-build}"

    mkdir -p "$GOBIN"

    path_prepend "$GOBIN"

    export PATH
fi


# ============================================================
# Prompt Bash
# ============================================================

COLOR_BLUE='\[\e[34m\]'
COLOR_CYAN='\[\e[36m\]'
COLOR_GREEN='\[\e[32m\]'
COLOR_YELLOW='\[\e[33m\]'
COLOR_RED='\[\e[31m\]'
COLOR_MAGENTA='\[\e[35m\]'
COLOR_WHITE='\[\e[37m\]'
COLOR_RESET='\[\e[0m\]'


__git_prompt_info() {
    local branch
    local git_status
    local result=""

    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        return
    fi

    branch="$(
        git symbolic-ref --short HEAD 2>/dev/null ||
        git rev-parse --short HEAD 2>/dev/null
    )"

    git_status="$(git status --porcelain 2>/dev/null)"

    result=" ${COLOR_MAGENTA} ${branch}${COLOR_RESET}"

    if [[ -n "$git_status" ]]; then
        # Неотслеживаемые файлы
        if grep -qE '^\?\?' <<< "$git_status"; then
            result+=" ${COLOR_RED}?${COLOR_RESET}"
        fi

        # Изменения в рабочем каталоге
        if grep -qE '^.[MADRCU]' <<< "$git_status"; then
            result+=" ${COLOR_YELLOW}!${COLOR_RESET}"
        fi

        # Изменения в индексе
        if grep -qE '^[MADRCU]' <<< "$git_status"; then
            result+=" ${COLOR_GREEN}+${COLOR_RESET}"
        fi
    fi

    printf "%b" "$result"
}


__update_prompt() {
    local exit_code=$?
    local status_color
    local status_symbol="❯"
    local git_info
    local current_time

    if [[ $exit_code -eq 0 ]]; then
        status_color="$COLOR_GREEN"
    else
        status_color="$COLOR_RED"
    fi

    current_time="$(date '+%H:%M:%S')"
    git_info="$(__git_prompt_info)"

    PS1="${COLOR_BLUE}┌─${COLOR_RESET}"
    PS1+="${COLOR_CYAN}\u${COLOR_RESET}@${COLOR_CYAN}\h${COLOR_RESET}"
    PS1+=" ${COLOR_YELLOW}${current_time}${COLOR_RESET}"
    PS1+=" ${COLOR_GREEN}\w${COLOR_RESET}"
    PS1+="${git_info}"
    PS1+=$'\n'
    PS1+="${COLOR_BLUE}└─${COLOR_RESET}"
    PS1+="${status_color}${status_symbol}${COLOR_RESET} "
}


PROMPT_COMMAND=(__update_prompt)


# ============================================================
# Дополнительные настройки Bash
# ============================================================

# Исправление некоторых опечаток в cd
shopt -s cdspell

# Автодополнение
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'

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
# Ctrl+T / Alt+C уже задаются fzf --bash
# ============================================================

if command -v fzf >/dev/null 2>&1 && command -v fd >/dev/null 2>&1; then
    ff() {
        local file
        file="$(fd --hidden --follow --exclude .git --exclude node_modules | fzf --preview 'bat --color=always --style=plain {} 2>/dev/null || cat {}')"
        if [[ -n "$file" ]]; then
            "${EDITOR:-micro}" "$file"
        fi
    }
    fcd() {
        local dir
        dir="$(fd --type d --hidden --follow --exclude .git --exclude node_modules | fzf)"
        if [[ -n "$dir" ]]; then
            cd "$dir"
        fi
    }
fi

# ============================================================
# grep/less и поиск по истории (h)
# ============================================================

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias less='less -R'

alias h='history | grep -i'                          # Поиск по истории
