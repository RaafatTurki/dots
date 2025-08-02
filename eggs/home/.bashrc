# black="\[\033[0;30m\]"
# red="\[\033[0;31m\]"
# green="\[\033[0;32m\]"
# yellow="\[\033[0;33m\]"
# blue="\[\033[0;34m\]"
# magenta="\[\033[0;35m\]"
# cyan="\[\033[0;36m\]"
# white="\[\033[0;37m\]"
#
# brblack="\[\033[1;30m\]"
# brred="\[\033[1;31m\]"
# brgreen="\[\033[1;32m\]"
# bryellow="\[\033[1;33m\]"
# brblue="\[\033[1;34m\]"
# brmagenta="\[\033[1;35m\]"
# brcyan="\[\033[1;36m\]"
# brwhite="\[\033[1;37m\]"
# rc="\[\033[0m\]"

# lazies
alias s='sudo'
alias se='sudo -E'
alias x='chmod +x'
alias xx='~/.xprofile'
alias aa='paru'
alias gg='gitui'
# alias gg='lazygit'
alias cb="xsel --input --clipboard"
alias ssh="env TERM=xterm-256color ssh"
alias neo="neofetch"
alias sc="systemctl"
alias jctlu="journalctl --no-pager -b -u"
alias jctl="journalctl --no-pager -b"
alias lsxprop="xprop -notype | grep -e '^WM' -e '^_NET' -e '^_GTK' | sort"
alias xkeys="xev -rv | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"

# live
alias wssh-agent-keys='watch ssh-add -l'
alias wtree='watch -c tree -C'
alias wgpu='watch -n 0.1 "cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status && cat /sys/bus/pci/devices/0000:00:02.0/power/runtime_status"'
alias wip='watch -n 0.1 -c ip -c a'
alias wblk='watch -n 0.1 -c lsblk'

# misc
alias find-node-modules="find . -name 'node_modules' -type d -prune -print | xargs du -chs"
alias find-and-clean-node-modules="find . -name 'node_modules' -type d -prune -print -exec gio trash '{}' \;"
alias pac-clean='sudo pacman -Rns (pacman -Qtdq)'
alias pac-diff='DIFFPROG="nvim -d $1" sudo -E pacdiff'
alias pac-unlock='sudo rm /var/lib/pacman/db.lck'
alias yt-audio='yt-dlp --extract-audio -f bestaudio'
alias yt-video='yt-dlp -f bestvideo+bestaudio'

# colors
alias ls="ls --color=auto"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c'
alias fdisk='fdisk --color=auto'
alias free='free -h'
alias tree='tree -C'
alias du='du -h'
alias less="$LESSPAGER"
alias echo='echo -n'
alias rg='rg --hidden'
alias lsblk="lsblk -o NAME,FSTYPE,FSSIZE,FSAVAIL,FSUSE%,MOUNTPOINT,LABEL"

# configs
alias profc="$EDITOR ~/.profile"
alias xprofc="$EDITOR ~/.xprofile"
alias nvims='nvim -c "SessionLoad"'
alias nvimses='sudo -E nvim -c "SessionLoad"'
alias nvim-nuke='rm -rf ~/.local/share/nvim; rm -rf ~/.local/state/nvim; rm -rf ~/.cache/nvim'
alias nvimc="cd $XDG_CONFIG_HOME/nvim && nvims"
alias mozc="cd ~/.mozilla && nvims"
alias cornc="cd ~/sectors/nvim/corn.nvim && nvims"
alias hexc="cd ~/sectors/nvim/hex.nvim && nvims"
alias rofic="cd $XDG_CONFIG_HOME/rofi && nvims"
alias nvimt="cd $XDG_CONFIG_HOME/nvim.test && NVIM_APPNAME=nvim.test nvims"
alias sshc="cd $HOME/.ssh && nvims"
alias gitc="cd $XDG_CONFIG_HOME/git && nvims"
alias fishc="cd $XDG_CONFIG_HOME/fish && nvims"
alias x11c="cd $XDG_CONFIG_HOME/x11/ && nvims"
alias hlwmc="cd $XDG_CONFIG_HOME/herbstluftwm/ && nvims"
alias tmuxc="cd $XDG_CONFIG_HOME/tmux/ && nvims"
alias bins="cd ~/.local/bin && nvims"
alias notes="cd ~/files/docs/notes && nvims"
alias boots="cd /boot && nvimses"
alias gtkc='nvim $XDG_CONFIG_HOME/gtk-2.0/gtkrc $XDG_CONFIG_HOME/gtk-3.0/settings.ini $XDG_CONFIG_HOME/gtk-4.0/settings.ini'

# XDG base dir compliance aliases
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias irssi="irssi --config=$XDG_CONFIG_HOME/irssi/config --home=$XDG_DATA_HOME/irssi"
