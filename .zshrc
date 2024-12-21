# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="xiong-chiamiov-plus"

# Basic Settings
umask 022
ENABLE_CORRECTION="true"

# Plugins
plugins=(git sudo web-search python pip history-substring-search colored-man-pages zsh-autosuggestions zsh-syntax-highlighting dnf eza)

source $ZSH/oh-my-zsh.sh
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
source <(fzf --zsh)

# History Settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
bindkey "^R" history-incremental-search-backward

# ZSH Cache Settings
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

# Terminal Settings
setopt auto_cd
setopt extended_glob
setopt interactive_comments
setopt no_beep
setopt correct
setopt correct_all

# System Settings
export GPG_TTY=$(tty)
export LC_ALL=tr_TR.UTF-8
export LANG=tr_TR.UTF-8
export PATH="$HOME/bin:$PATH"

# Quick Directory Access
hash -d docs=~/Documents
hash -d down=~/Downloads
hash -d pics=~/Pictures

# File Listing (eza)
alias ls='eza -al --color=always --group-directories-first --icons'
alias la='eza -a --color=always --group-directories-first --icons'
alias ll='eza -l --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first --icons'
alias l.="eza -a | grep -e '^\.'"

# Directory Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias zrc='source ~/.zshrc'
alias reload='source ~/.zshrc'

# File Operations
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -I --preserve-root'
alias mkdir='mkdir -pv'
alias shred='shred -u -v -n 35 -z'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# System Monitoring and Management
alias df='df -h'
alias du='du -ch'
alias free='free -m'
alias top='btop'
alias psu='ps -U $USER -u $USER u'
alias usage='du -ch --max-depth=1'
alias sysupdate='sudo dnf update -y && flatpak update -y'
alias cleanup='sudo dnf clean all && flatpak remove --unused'
alias ports='sudo ss -tulanp'
alias services='systemctl list-units --type=service --state=running'
alias mem='free -h | grep "^Mem"'
alias cpu='top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk "{print 100 - \$1\"%\"}"'
alias temp='sensors | grep "Core"'
alias disk='df -h | grep "^/dev/"'
alias net='nethogs'
alias updates='dnf check-update | grep -v "^$" | wc -l'
alias sysmaint='sudo dnf autoremove && sudo dnf clean all && flatpak remove --unused && sudo journalctl --vacuum-time=7d'
alias logsize='journalctl --disk-usage'
alias bigfiles='du -h /home/$USER/ | sort -rh | head -n 20'

# Network Tools and Security
alias wget='wget -c'
alias curl='curl -O -L -C - -#'
alias myip='wget -qO- ifconfig.io/ip ; echo'
alias ipv4="nmcli device show | awk '/IP4.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ipv6="nmcli device show | awk '/IP6.ADDRESS/{print \$2}' | cut -d'/' -f1 | head -1"
alias ports-open='sudo lsof -i -P -n | grep LISTEN'
alias firewall='sudo firewall-cmd --list-all'
alias connections='sudo netstat -tulanp'

# Search Functions
alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias ftext='grep -Rin --color'
alias ara='ara(){ find / -type f -name "$@" -print 2>/dev/null }; ara'

# Git Shortcuts
alias gs='git status'
alias ga='git add .'
alias gc='f() { 
    local cyber=("⟊" "⟧" "⟨" "⟩" "⟪" "⟫" "⟰" "⟱" "⟲" "⟳" "⟴" "⟵" "⟶" "⟷" "⟸" "⟹" "⟺" "⟻" "⟼" "⟽" "⟾" "⟿")
    local kanji=("零" "壱" "弐" "参" "肆" "伍" "陸" "漆" "捌" "玖" "拾")
    local matrix=("⠅" "⠆" "⠇" "⠈" "⠉" "⠊" "⠋" "⠌" "⠍" "⠎" "⠏" "⠐" "⠑" "⠒" "⠓" "⠔" "⠕" "⠖" "⠗" "⠘" "⠙" "⠚" "⠛" "⠜" "⠝" "⠞" "⠟" "⠠" "⠡" "⠢" "⠣" "⠤" "⠥" "⠦" "⠧" "⠨" "⠩" "⠪" "⠫" "⠬" "⠭" "⠮" "⠯" "⠰" "⠱" "⠲" "⠳" "⠴" "⠵" "⠶" "⠷" "⠸" "⠹" "⠺" "⠻" "⠼" "⠽" "⠾" "⠿")
    local elements=("炎" "氷" "風" "雷" "闇" "光" "空" "星" "夢" "魂" "命" "霊" "鬼" "龍" "神")
    local time=$(date +%H:%M)
    local date=$(date +%d)
    printf -v commit "git commit -m \"%s%s %s %s %s%s\"" "${cyber[$RANDOM % ${#cyber[@]}]}" "${matrix[$RANDOM % ${#matrix[@]}]}" "${elements[$RANDOM % ${#elements[@]}]}" "${kanji[$((date % 11))]}" "${matrix[$RANDOM % ${#matrix[@]}]}" "$time"
    eval $commit
}; f'
alias gp='git push -u origin main'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gcl='git clone --depth 1'

# Archive Operations
alias tarc='tar -czvf'
alias tarx='tar -xzvf'
alias tarl='tar -tzvf'
alias zipc='zip -r'
alias unzipc='unzip'
alias sar='sar(){ tar -cf - --no-same-owner "$@" | pv -s $(du -sb "$@" | awk '"'"'{print $1}'"'"') > "$@.tar"; unset -f sar; }; sar'
alias coz='coz(){ tar -xf --no-same-owner "$@" | pv -s $(du -sb "$@" | awk '"'"'{print $1}'"'"'); unset -f coz; }; coz'

# Media and Conversion
alias yt='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --merge-output-format mp4'
alias mp3="yt-dlp -x --embed-thumbnail --audio-format mp3"
alias mkv2mp4='mkv2mp4(){ ffmpeg -v quiet -stats -i "$@" -c copy -c:a aac -movflags +faststart "${@%%.*}.mp4" }; mkv2mp4'

# Flatpak Management
alias fpk='flatpak'
alias fpki='flatpak install'
alias fpkr='flatpak run'
alias fpku='flatpak update'
alias fpkun='flatpak uninstall'
alias fpkls='flatpak list --app --columns=application,version,size,installation'
alias fpks='flatpak search'
alias fpkrm='f(){ echo "Installed Flatpak apps:"; echo "----------------------------"; flatpak list --app --columns=application; echo "----------------------------"; read -p "Enter app name to remove: " app; if [ -z "$app" ]; then echo "App name required"; else echo "Removing: $app"; flatpak uninstall --delete-data "$app" && flatpak remove --unused && rm -rf ~/.var/app/"$app" ~/.cache/"$app" && echo "$app successfully removed."; fi; unset -f f; }; f'
alias fpkclean='flatpak uninstall --unused && flatpak repair'
alias fpkrepair='flatpak repair --user && flatpak repair --system'
alias fpksize='du -sh ~/.var/app/* | sort -h'

# Utility Functions
alias j='jsonVer(){ cat "$@" | jq; unset -f jsonVer; }; jsonVer'
alias md2pdf='md2pdf(){ pandoc -o "${@%%.*}.pdf" --template pdf_theme --listings --pdf-engine=xelatex --toc "$@"; unset -f md2pdf; }; md2pdf'
alias p="python3"

# Auto-completion and Highlighting
autoload -U compinit
compinit

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

function cd() {
    builtin cd "$@" && ls
}

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down