# ~/.zshrc

# =============================================================================
# 1. ENVIRONMENT VARIABLES
# =============================================================================
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export EDITOR="nano"
export VISUAL="nano"


# =============================================================================
# 2. OH MY ZSH & PLUGINS
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnosterzak"

plugins=(
    git sudo web-search
    python pip docker 
    history-substring-search fzf
    colored-man-pages archlinux eza
)

source "$ZSH/oh-my-zsh.sh"


# =============================================================================
# 3. HISTORY CONFIGURATION
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt share_history

HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..|c)"


# =============================================================================
# 4. ZSH COMPLETION & OPTIONS
# =============================================================================
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


# =============================================================================
# 5. ALIASES
# =============================================================================

# -- Navigation & Basic Commands --
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias zrc='source ~/.zshrc'
alias zedit='$EDITOR ~/.zshrc'
alias path='print -l $path'

# -- File Operations --
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -I --preserve-root --one-file-system'
alias mkdir='mkdir -pv'
alias shred='shred -u -v -n 35 -z'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

if command -v eza &> /dev/null; then
    alias ls='eza -al --color=always --group-directories-first --icons'
    alias la='eza -a --color=always --group-directories-first --icons'
    alias ll='eza -l --color=always --group-directories-first --icons'
    alias lt='eza -aT --color=always --group-directories-first --icons'
    alias l.="eza -a | grep -e '^\.'"
else
    alias ls='ls --color=auto -al'
    alias la='ls --color=auto -A'
    alias ll='ls --color=auto -l'
fi

if command -v bat &> /dev/null; then
    alias cat='bat'
fi

if command -v dircolors &> /dev/null; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# -- System & Monitoring --
alias df='df -h'
alias du='du -ch'
alias usage='du -ch -d 1'
alias free='free -m'
alias mem="free -h | awk '/^Mem:/ {print \$3 \" / \" \$2}'"
alias cpu="vmstat 1 2 | tail -1 | awk '{printf \"%d%%\\n\", 100 - \$15}'"
alias disk='df -h | grep "^/dev/"'
alias temp='sensors | grep "Core"'
alias top='btop'
alias psu='ps -U $USER -u $USER u'
alias ports='sudo ss -tulanp'

# -- Systemd & Journal --
alias sc='sudo systemctl'
alias scu='systemctl --user'
alias scs='sudo systemctl status'
alias jc='sudo journalctl -xeu'
alias jcf='sudo journalctl -f'

# -- Package Managers (Arch / CachyOS) --
alias sysupdate='paru -Syu && flatpak update -y'
alias cleanup='paru -c && paru -Sc --noconfirm && flatpak remove --unused'
alias sysmaint='paru -c && paru -Sc --noconfirm && flatpak remove --unused && sudo journalctl --vacuum-time=7d'

alias paci='sudo pacman -S'
alias pacr='sudo pacman -Rns'
alias pacs='pacman -Ss'
alias pacinfo='pacman -Si'

alias pari='paru -S'
alias parr='paru -Rns'
alias pars='paru -Ss'
alias parinfo='paru -Si'

alias upmirrors='sudo cachyos-rate-mirrors'

# -- Flatpak --
alias fpk='flatpak'
alias fpki='flatpak install'
alias fpkr='flatpak run'
alias fpku='flatpak update'
alias fpkun='flatpak uninstall'
alias fpkls='flatpak list --app --columns=application,version,size,installation'
alias fpks='flatpak search'

# -- Network --
alias wget='wget -c'
alias curl='curl -O -L -C - -#'
alias myip='wget -qO- ifconfig.io/ip ; echo'
alias ipv4="nmcli device show | awk '/IP4.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ipv6="nmcli device show | awk '/IP6.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ping='ping -c 5'
alias ssh='ssh -o ConnectTimeout=5 -o LogLevel=ERROR -o StrictHostKeyChecking=no'
alias set-ttl-65='sudo sysctl -w net.ipv4.ip_default_ttl=65'

# -- Git --
alias gp='git push -u origin $(git branch --show-current)'

# -- Media & Misc --
alias yt='yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" --merge-output-format mp4'
alias mp3='yt-dlp -x --embed-thumbnail --audio-format mp3'
alias p='python3'


# =============================================================================
# 6. FUNCTIONS
# =============================================================================

search() { 
    find / -type f -name "*$1*" -print 2>/dev/null 
}

pack() {
    if [ -z "$1" ]; then
        echo "Usage: pack <file/dir>"
        return 1
    fi
    local target="${1%/}"
    tar -cf - "$@" | pv -s $(du -scb "$@" | tail -1 | awk '{print $1}') > "${target}.tar"
}

unpack() {
    if [ -z "$1" ]; then
        echo "Usage: unpack <file.tar>"
        return 1
    fi
    pv "$1" | tar -xf -
}

ex() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2|*.tar.gz|*.tar|*.tbz2|*.tgz|*.tar.xz) tar xf "$1" ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *.xz)        unxz "$1"       ;;
            *)           echo "Error: '$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "Error: '$1' is not a valid file"
    fi
}

mkv2mp4() {
    if [ -z "$1" ]; then
        echo "Usage: mkv2mp4 <video.mkv>"
        return 1
    fi
    ffmpeg -v quiet -stats -i "$1" -c copy -c:a aac -movflags +faststart "${1%.*}.mp4"
}

j() {
    if command -v jq &> /dev/null; then
        jq . "$1"
    else
        echo "Error: jq is not installed"
    fi
}

md2pdf() {
    if command -v pandoc &> /dev/null; then
        pandoc -o "${1%.*}.pdf" --template pdf_theme --listings --pdf-engine=xelatex --toc "$1"
    else
        echo "Error: pandoc is not installed"
    fi
}

genpass() {
    local length=20
    local use_specials=1

    # Check arguments
    for arg in "$@"; do
        if [[ "$arg" =~ ^[0-9]+$ ]]; then
            length="$arg"
        elif [[ "$arg" == "-s" || "$arg" == "--no-special" ]]; then
            use_specials=0
        elif [[ "$arg" == "-h" || "$arg" == "--help" ]]; then
            echo "Kullanım: genpass [uzunluk] [-s|--no-special]"
            echo "Örnekler:"
            echo "  genpass             (20 karakter, özel karakterli)"
            echo "  genpass 16          (16 karakter, özel karakterli)"
            echo "  genpass 12 -s       (12 karakter, özel karaktersiz)"
            return 0
        fi
    done

    local charset='A-Za-z0-9'
    if [[ $use_specials -eq 1 ]]; then
        charset="${charset}!@#$%^&*()_+{}|:<>?="
    fi

    local pass=$(LC_ALL=C tr -dc "$charset" < /dev/urandom | head -c "$length")
    echo "$pass"
    
    if command -v wl-copy &> /dev/null; then
        echo -n "$pass" | wl-copy
        echo "(Panoya kopyalandı - Wayland)"
    elif command -v xclip &> /dev/null; then
        echo -n "$pass" | xclip -selection clipboard
        echo "(Panoya kopyalandı - X11)"
    fi
}


# =============================================================================
# 7. SHELL INTEGRATIONS
# =============================================================================

if command -v dircolors &> /dev/null; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if command -v fzf &> /dev/null; then
    source <(fzf --zsh)
fi

[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if command -v fastfetch &> /dev/null; then
    fastfetch -c "$HOME/.config/fastfetch/config-compact.jsonc"
fi
