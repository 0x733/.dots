# =============================================================================
#  ███████╗███████╗██╗  ██╗██████╗  ██████╗ 
#  ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝ 
#    ███╔╝ ███████╗███████║██████╔╝██║      
#   ███╔╝  ╚════██║██╔══██║██╔══██╗██║      
#  ███████╗███████║██║  ██║██║  ██║╚██████╗ 
#  ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ 
# 
#  PERSONAL ZSH CONFIGURATION (FEDORA LINUX)
# =============================================================================

# -----------------------------------------------------------------------------
# 01. ENVIRONMENT VARIABLES
# -----------------------------------------------------------------------------
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Default editor setup (change to nvim or vim if preferred)
export EDITOR="nano"
export VISUAL="nano"

# -----------------------------------------------------------------------------
# 02. OH-MY-ZSH CONFIGURATION
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnosterzak"

# Standard Oh-My-Zsh plugins
plugins=(
    git sudo web-search
    python pip docker 
    history-substring-search fzf
    colored-man-pages dnf eza
)

source "$ZSH/oh-my-zsh.sh"

# -----------------------------------------------------------------------------
# 03. SYSTEM OPTIONS & BEHAVIOR
# -----------------------------------------------------------------------------
# Fastfetch (Run on startup)
if command -v fastfetch &> /dev/null; then
    fastfetch -c "$HOME/.config/fastfetch/config-compact.jsonc"
fi

# Directory navigation
setopt auto_cd              # Auto cd when typing a directory name
setopt auto_pushd           # Make cd push the old directory onto the directory stack
setopt pushd_ignore_dups    # Don't push multiple copies of the same directory

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history       # Append history list to the history file
setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_save_no_dups    # Do not write duplicate entries in the history file
setopt hist_find_no_dups    # Do not display duplicates when searching
setopt share_history        # Share history between all sessions

HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..|c)"

# FZF key bindings (CTRL+R fuzzy history)
if command -v fzf &> /dev/null; then
    source <(fzf --zsh)
fi

# Completions (Handled primarily by Oh-My-Zsh)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion

# -----------------------------------------------------------------------------
# 04. ALIASES: NAVIGATION & FILES
# -----------------------------------------------------------------------------
# Directory traversal
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -='cd -'              # Go back to previous directory

# Modern terminal replacements (eza and bat)
if command -v eza &> /dev/null; then
    alias ls='eza -al --color=always --group-directories-first --icons'
    alias la='eza -a --color=always --group-directories-first --icons'
    alias ll='eza -l --color=always --group-directories-first --icons'
    alias lt='eza -aT --color=always --group-directories-first --icons'
    alias l.="eza -a | grep -e '^\.'"
else
    # Fallbacks if eza is not installed
    alias ls='ls --color=auto -al'
    alias la='ls --color=auto -A'
    alias ll='ls --color=auto -l'
fi

if command -v bat &> /dev/null; then
    alias cat='bat'
fi

# File operations (Safe defaults)
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -I --preserve-root --one-file-system'
alias mkdir='mkdir -pv'
alias shred='shred -u -v -n 35 -z'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Print PATH nicely
alias path='echo -e ${PATH//:/\\n}'

# -----------------------------------------------------------------------------
# 05. ALIASES: SYSTEM & PROCESSES
# -----------------------------------------------------------------------------
# General system aliases
alias c='clear'
alias zrc='source ~/.zshrc'
alias zedit='$EDITOR ~/.zshrc'

# Disk, memory, and CPU monitoring
alias df='df -h'
alias du='du -ch'
alias usage='du -ch -d 1'
alias free='free -m'
alias mem="free -h | awk '/^Mem:/ {print \$3 \" / \" \$2}'"
alias cpu="vmstat 1 2 | tail -1 | awk '{print 100 - \$15\"%\"}'"
alias disk='df -h | grep "^/dev/"'
alias temp='sensors | grep "Core"'
alias top='btop'

# Process and network monitoring
alias psu='ps -U $USER -u $USER u'
alias ports='sudo ss -tulanp'   # Show listening ports and processes

# Systemd (Services & Logs)
alias sc='sudo systemctl'
alias scu='systemctl --user'
alias scs='sudo systemctl status'
alias jc='sudo journalctl -xeu' # Journalctl advanced view (pager, to the end)
alias jcf='sudo journalctl -f'  # Follow live journal logs

# -----------------------------------------------------------------------------
# 06. ALIASES: FEDORA & PACKAGES
# -----------------------------------------------------------------------------
# DNF Shortcuts (System maintenance)
alias sysupdate='sudo dnf update -y && flatpak update -y'
alias cleanup='sudo dnf clean all && flatpak remove --unused'
alias sysmaint='sudo dnf autoremove && sudo dnf clean all && flatpak remove --unused && sudo journalctl --vacuum-time=7d'

alias dnfi='sudo dnf install'
alias dnfr='sudo dnf remove'
alias dnfs='dnf search'
alias dnfi-info='dnf info'

# Flatpak Shortcuts
alias fpk='flatpak'
alias fpki='flatpak install'
alias fpkr='flatpak run'
alias fpku='flatpak update'
alias fpkun='flatpak uninstall'
alias fpkls='flatpak list --app --columns=application,version,size,installation'
alias fpks='flatpak search'

# -----------------------------------------------------------------------------
# 07. ALIASES: NETWORK & GIT
# -----------------------------------------------------------------------------
# Network tools
alias wget='wget -c'
alias curl='curl -O -L -C - -#'
alias myip='wget -qO- ifconfig.io/ip ; echo'
alias ipv4="nmcli device show | awk '/IP4.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ipv6="nmcli device show | awk '/IP6.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ping='ping -c 5'
alias ssh='ssh -o ConnectTimeout=5 -o LogLevel=ERROR -o StrictHostKeyChecking=no'

# Git shortcuts
alias gs='git status'
alias ga='git add .'
alias gp='git push -u origin main'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gcl='git clone --depth 1'
alias gc='git commit -m'

# Media specific shortcuts
alias yt='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --merge-output-format mp4'
alias mp3='yt-dlp -x --embed-thumbnail --audio-format mp3'
alias p='python3'

# -----------------------------------------------------------------------------
# 08. FUNCTIONS (UTILITIES)
# -----------------------------------------------------------------------------

# Quick search for files in the system
search() { 
    find / -type f -name "*$1*" -print 2>/dev/null 
}

# Create a TAR archive with progress bar
pack() {
    if [ -z "$1" ]; then
        echo "Usage: pack <file/dir>"
        return 1
    fi
    local target="${1%/}"
    tar -cf - "$@" | pv -s $(du -scb "$@" | tail -1 | awk '{print $1}') > "${target}.tar"
}

# Extract a TAR archive with progress bar
unpack() {
    if [ -z "$1" ]; then
        echo "Usage: unpack <file.tar>"
        return 1
    fi
    pv "$1" | tar -xf -
}

# Universal archive extractor
ex() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *.xz)        unxz "$1"       ;;
            *.tar.xz)    tar xJf "$1"    ;;
            *)           echo "Error: '$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "Error: '$1' is not a valid file"
    fi
}

# Convert MKV to MP4 fast without re-encoding video
mkv2mp4() {
    if [ -z "$1" ]; then
        echo "Usage: mkv2mp4 <video.mkv>"
        return 1
    fi
    ffmpeg -v quiet -stats -i "$1" -c copy -c:a aac -movflags +faststart "${1%.*}.mp4"
}

# View JSON file using jq
j() {
    if command -v jq &> /dev/null; then
        jq . "$1"
    else
        echo "Error: jq is not installed"
    fi
}

# Convert Markdown to PDF using Pandoc
md2pdf() {
    if command -v pandoc &> /dev/null; then
        pandoc -o "${1%.*}.pdf" --template pdf_theme --listings --pdf-engine=xelatex --toc "$1"
    else
        echo "Error: pandoc is not installed"
    fi
}

# Generate a strong random password
genpass() {
    local length=${1:-20}
    LC_ALL=C tr -dc 'A-Za-z0-9@%^_+' < /dev/urandom | head -c $length
    echo
}

# -----------------------------------------------------------------------------
# 09. PLUGINS & INTEGRATIONS (MANUAL FALLBACK)
# -----------------------------------------------------------------------------

# Colors for ls/grep
if command -v dircolors &> /dev/null; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Fedora System-wide Zsh plugins
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
