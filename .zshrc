#  ╭──────────────────────────────────────────────────────────╮
#  │                    ZSH CONFIGURATION                     │
#  │        Crafted with ♥ for Maximum Productivity          │
#  ╰──────────────────────────────────────────────────────────╯

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃                  CORE CONFIGURATION                      ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="xiong-chiamiov-plus"
umask 022
ENABLE_CORRECTION="true"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="xiong-chiamiov-plus"
umask 022
ENABLE_CORRECTION="true"
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
source <(fzf --zsh)

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃                      PLUGINS                            ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
plugins=(
    git sudo web-search
    python pip docker direnv
    history-substring-search fzf
    colored-man-pages dnf eza
    zsh-autosuggestions
    zsh-syntax-highlighting
)

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃                  HISTORY SETTINGS                       ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
bindkey "^R" history-incremental-search-backward

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃                  SHELL OPTIONS                         ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
setopt auto_cd extended_glob interactive_comments no_beep correct correct_all

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              ENVIRONMENT VARIABLES                      ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
export GPG_TTY=$(tty)
export LC_ALL=tr_TR.UTF-8
export LANG=tr_TR.UTF-8
export PATH="$HOME/bin:$PATH"

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              COMPLETION SETTINGS                        ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              DIRECTORY SHORTCUTS                        ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
hash -d docs=~/Documents
hash -d down=~/Downloads
hash -d pics=~/Pictures

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              FILE MANAGEMENT ALIASES                    ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias ls='eza -al --color=always --group-directories-first --icons'
alias la='eza -a --color=always --group-directories-first --icons'
alias ll='eza -l --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first --icons'
alias l.="eza -a | grep -e '^\.'"

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              NAVIGATION & BASIC COMMANDS               ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias zrc='source ~/.zshrc'
alias reload='source ~/.zshrc'

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              SAFE OPERATIONS                           ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -I --preserve-root --one-file-system'
alias mkdir='mkdir -pv'
alias shred='shred -u -v -n 35 -z'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              SYSTEM MONITORING                         ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias df='df -h'
alias du='du -ch'
alias free='free -m'
alias top='btop'
alias psu='ps -U $USER -u $USER u'
alias usage='du -ch --max-depth=1'
alias mem='free -h | grep "^Mem"'
alias cpu='top -bn1 | grep "Cpu(s)" | sed "s/.*, _\([0-9.]_\)%* id.*/\1/" | awk "{print 100 - \$1\"%\"}"'
alias temp='sensors | grep "Core"'
alias disk='df -h | grep "^/dev/"'

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              SYSTEM MAINTENANCE                        ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias sysupdate='sudo dnf update -y && flatpak update -y'
alias cleanup='sudo dnf clean all && flatpak remove --unused'
alias sysmaint='sudo dnf autoremove && sudo dnf clean all && flatpak remove --unused && sudo journalctl --vacuum-time=7d'

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              FLATPAK MANAGEMENT                        ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias fpk='flatpak'
alias fpki='flatpak install'
alias fpkr='flatpak run'
alias fpku='flatpak update'
alias fpkun='flatpak uninstall'
alias fpkls='flatpak list --app --columns=application,version,size,installation'
alias fpks='flatpak search'

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              NETWORK TOOLS                            ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias wget='wget -c'
alias curl='curl -O -L -C - -#'
alias myip='wget -qO- ifconfig.io/ip ; echo'
alias ipv4="nmcli device show | awk '/IP4.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ipv6="nmcli device show | awk '/IP6.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ssh='ssh -o ConnectTimeout=5 -o LogLevel=ERROR -o StrictHostKeyChecking=no'

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              GIT SHORTCUTS                            ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias gs='git status'
alias ga='git add .'
alias gp='git push -u origin main'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gcl='git clone --depth 1'
alias gc='f() {
    m=("♠" "♥" "♦" "♣" "♤" "♡" "♢" "♧")
    date=$(date +"%d-%m-%Y %H:%M")
    user=$(whoami)
    branch=$(git branch --show-current)
    printf -v k "git commit -m \"%s [%s@%s] %s\"" \
    "${m[$RANDOM % ${#m[@]}]}" \
    "$user" \
    "$branch" \
    "$date"
    eval $k
}; f'

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              UTILITY FUNCTIONS                         ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
genpass() {
    local length=${1:-20}
    LC_ALL=C tr -dc 'A-Za-z0-9@%^_+' < /dev/urandom | head -c $length
    echo
}

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              ARCHIVE MANAGEMENT                        ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias pack='pack(){ tar -cf - --no-same-owner "$@" | pv -s $(du -sb "$@" | awk '"'"'{print $1}'"'"') > "$@.tar"; unset -f pack; }; pack'
alias unpack='unpack(){ tar -xf --no-same-owner "$@" | pv -s $(du -sb "$@" | awk '"'"'{print $1}'"'"'); unset -f unpack; }; unpack'
alias tarc='tar -czvf'
alias tarx='tar -xzvf'
alias tarl='tar -tzvf'
alias zipc='zip -r'
alias unzipc='unzip'

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              MEDIA TOOLS                              ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias yt='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --merge-output-format mp4'
alias mp3="yt-dlp -x --embed-thumbnail --audio-format mp3"
alias mkv2mp4='mkv2mp4(){ ffmpeg -v quiet -stats -i "$@" -c copy -c:a aac -movflags +faststart "${@%%.*}.mp4" }; mkv2mp4'

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              DEVELOPMENT TOOLS                        ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias j='jsonView(){ cat "$@" | jq; unset -f jsonView; }; jsonView'
alias md2pdf='md2pdf(){ pandoc -o "${@%%.*}.pdf" --template pdf_theme --listings --pdf-engine=xelatex --toc "$@"; unset -f md2pdf; }; md2pdf'
alias p="python3"

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              COMPLETION & HIGHLIGHTING                 ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
autoload -U compinit && compinit
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              PLUGIN SOURCES                           ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              KEY BINDINGS                             ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              ENHANCED FUNCTIONS                        ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
function cd() {
    builtin cd "$@" && ls
}

#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃              SEARCH FUNCTIONS                         ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias ftext='grep -Rin --color'
alias search='search(){ find / -type f -name "$@" -print 2>/dev/null }; search'

#  ╭──────────────────────────────────────────────────────────╮
#  │                   END OF CONFIGURATION                   │
#  │            May your terminal serve you well!             │
#  ╰──────────────────────────────────────────────────────────╯