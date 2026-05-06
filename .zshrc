# ~/.zshrc

# =============================================================================
# 1. ENVIRONMENT VARIABLES
# =============================================================================
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/.npm-global/bin:$HOME/.pnpm:$HOME/.local/share/pnpm:$HOME/.abacusai/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:$PATH"
export EDITOR="nano"
export VISUAL="nano"

if command -v bat &> /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export BAT_THEME="TwoDark"
fi

export LESS='-R --mouse --wheel-lines=3'
export LESSHISTFILE=-
export REPORTTIME=10
export TIMEFMT='%J: %*Es'


# =============================================================================
# 2. OH MY ZSH & PLUGINS
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
if command -v starship &> /dev/null; then
    ZSH_THEME=""
elif [ -f "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme" ]; then
    ZSH_THEME="powerlevel10k/powerlevel10k"
else
    ZSH_THEME="agnoster"
fi

plugins=(
    git sudo web-search
    python pip docker
    history-substring-search
    colored-man-pages eza
    command-not-found
)

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

source "$ZSH/oh-my-zsh.sh"

if command -v starship &> /dev/null; then
    export STARSHIP_CONFIG="$HOME/Belgeler/Projeler/dotfiles/.config/starship.toml"
    eval "$(starship init zsh)"
elif [ -f "$HOME/Belgeler/Projeler/dotfiles/.p10k.zsh" ]; then
    source "$HOME/Belgeler/Projeler/dotfiles/.p10k.zsh"
elif [ -f ~/.p10k.zsh ]; then
    source ~/.p10k.zsh
fi


# =============================================================================
# 3. HISTORY CONFIGURATION
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY
setopt HIST_FCNTL_LOCK
setopt SHARE_HISTORY

HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..|c)"


# =============================================================================
# 4. ZSH COMPLETION & OPTIONS
# =============================================================================
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt NO_BEEP
setopt EXTENDED_GLOB
setopt GLOB_DOTS

_comp_options+=(globdots)
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches: %d --%f'


# =============================================================================
# 5. KEYBINDINGS
# =============================================================================
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
bindkey '^[^[[C' forward-word
bindkey '^[^[[D' backward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^H' backward-kill-word
bindkey '^U' backward-kill-line
bindkey '^[.' insert-last-word


# =============================================================================
# 6. FZF CONFIGURATION
# =============================================================================
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_R_OPTS='--sort --exact'


# =============================================================================
# 7. ALIASES
# =============================================================================

# -- Global --
alias -g G='| grep -i'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g C='| wl-copy'
alias -g NUL='>/dev/null 2>&1'

# -- Suffix --
if command -v mpv &> /dev/null; then
    alias -s {mp4,mkv,avi,webm,MP4,MKV,AVI}=mpv
fi
if command -v zathura &> /dev/null; then
    alias -s {pdf,PDF}=zathura
fi
if command -v imv &> /dev/null; then
    alias -s {jpg,jpeg,png,gif,webp,bmp,JPG,PNG}=imv
fi
if command -v firefox &> /dev/null; then
    alias -s {html,htm}=firefox
fi

# -- Navigation & Basic Commands --
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias zrc='source ~/.zshrc'
alias zedit='$EDITOR ~/Belgeler/Projeler/dotfiles/.zshrc'
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

if command -v trash &> /dev/null; then
    alias tp='trash'
fi

# -- System & Monitoring --
alias df='df -h'
alias du='du -ch --max-depth=1'
alias free='free -m'
alias mem="free -h | awk '/^Mem:/ {print \$3 \" / \" \$2}'"
if command -v sensors &> /dev/null; then
    alias temp='sensors | grep "Core"'
fi
if command -v btop &> /dev/null; then
    alias top='btop'
fi
alias ports='sudo ss -tulanp'
alias ip='ip --color=auto'
alias mkp='make -j$(nproc)'

# -- Systemd & Journal --
alias sc='sudo systemctl'
alias scu='systemctl --user'
alias scs='sudo systemctl status'
alias jc='sudo journalctl -xeu'
alias jcf='sudo journalctl -f'
alias jcb='sudo journalctl -b'
alias boottime='systemd-analyze && systemd-analyze blame | head -20'

# -- Package Managers (Fedora / DNF) --
alias sysupdate='sudo dnf upgrade -y && flatpak update -y'
alias cleanup='sudo dnf autoremove -y && sudo dnf clean all && flatpak remove --unused'
alias sysmaint='sudo dnf autoremove -y && sudo dnf clean all && flatpak remove --unused && sudo journalctl --vacuum-time=7d'

alias dnfi='sudo dnf install'
alias dnfr='sudo dnf remove'
alias dnfs='dnf search'
alias dnfinfo='dnf info'

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
alias curl='curl -L -#'
alias curlget='curl -O -L -C - -#'
alias myip='wget -qO- ifconfig.io/ip ; echo'
alias ipv4="nmcli device show | awk '/IP4.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ipv6="nmcli device show | awk '/IP6.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ping='ping -c 5'
alias ssh='ssh -o ConnectTimeout=5 -o LogLevel=ERROR -o StrictHostKeyChecking=accept-new'
alias set-ttl-65='sudo sysctl -w net.ipv4.ip_default_ttl=65'

# -- rsync --
alias rcp='rsync -avh --progress'
alias rmv='rsync -avh --progress --remove-source-files'
alias rbk='rsync -avh --progress --backup --backup-dir=$(date +%Y%m%d)'

# -- Git --
alias gp='git push -u origin $(git branch --show-current)'

# -- Media & Misc --
if command -v yt-dlp &> /dev/null; then
    alias yt='yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" --merge-output-format mp4'
    alias mp3='yt-dlp -x --embed-thumbnail --audio-format mp3'
fi
alias p='python3'


# =============================================================================
# 8. FUNCTIONS
# =============================================================================

search() {
    local dir="${2:-.}"
    find "$dir" -type f -iname "*$1*" 2>/dev/null
}

up() {
    local count="${1:-1}"
    local path=""
    for i in $(seq 1 "$count"); do
        path="../$path"
    done
    cd "$path" || return 1
}

mkcd() { mkdir -p "$1" && cd "$1" }

cdl() { cd "$1" && ls }

bak() {
    if [ -z "$1" ]; then
        echo "Usage: bak <file>"
        return 1
    fi
    cp -iv "$1" "${1}.bak.$(date +%Y%m%d_%H%M%S)"
}

sysinfo() {
    echo "OS:     $(uname -sr)"
    echo "Host:   $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Memory: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    echo "Disk:   $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
}

ex() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2|*.tar.gz|*.tar|*.tbz2|*.tgz|*.tar.xz) tar xf "$1" ;;
            *.tar.zst)   tar --use-compress-program=unzstd -xf "$1" ;;
            *.zst)       unzstd "$1" ;;
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

j() {
    if command -v jq &> /dev/null; then
        jq . "$1"
    else
        echo "Error: jq is not installed"
    fi
}

genpass() {
    local length=20
    local use_specials=1

    for arg in "$@"; do
        if [[ "$arg" =~ ^[0-9]+$ ]]; then
            length="$arg"
        elif [[ "$arg" == "-n" || "$arg" == "--no-special" ]]; then
            use_specials=0
        elif [[ "$arg" == "-h" || "$arg" == "--help" ]]; then
            echo "Kullanım: genpass [uzunluk] [-n|--no-special]"
            echo "Örnekler:"
            echo "  genpass             (20 karakter, özel karakterli)"
            echo "  genpass 16          (16 karakter, özel karakterli)"
            echo "  genpass 12 -n       (12 karakter, özel karaktersiz)"
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
# 9. SHELL INTEGRATIONS
# =============================================================================

if command -v dircolors &> /dev/null; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if command -v fzf &> /dev/null; then
    source <(fzf --zsh)
fi

[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

if command -v fastfetch &> /dev/null; then
    fastfetch -c "$HOME/.config/fastfetch/config-compact.jsonc"
fi
