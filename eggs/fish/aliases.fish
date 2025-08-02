# essential
alias s='sudo'
alias se='sudo -E'
alias x='chmod +x'
alias aa='paru'
alias gg='gitui'
alias cb="xsel --input --clipboard"
alias ssh="env TERM=xterm-256color ssh"
alias ssh-pub="ssh-keygen -y -f"
alias ssh-sig="ssh-keygen -l -f"
alias neo="fastfetch"
alias sd="systemctl"
alias rmrf="rm -rf"

alias jctlu="journalctl --no-pager -b -u"
alias jctl="journalctl --no-pager -b"
alias mimetype='xdg-mime query filetype'

# listings
alias lspath="echo $PATH | tr ':' '\n'"
alias lsdu='du -h -a --max-depth=0 -- * | sort -rh'
alias lsusers="cat /etc/passwd | cut -d : -f 1"
alias lskernelparams="cat /proc/cmdline | tr ' ' '\n'"
alias lsenv="env | sort"
alias lsfont='fc-list : family | sort | fzf'
alias lslib32="aa -Qsq | grep lib32 | fzf | xargs pacman -Qi"
alias lspcifzf="lspci | fzf --preview-window='top:50%:nowrap' --preview=\"echo {} | grep -o '[0-9a-zA-Z][0-9a-zA-Z]:[0-9a-zA-Z][0-9a-zA-Z]\.[0-9a-zA-Z]' | xargs -I[] lspci -k -s [] | grep -z --color=always -e '[0-9a-zA-Z][0-9a-zA-Z]:[0-9a-zA-Z][0-9a-zA-Z]\.[0-9a-zA-Z]'\""
alias lsxprop="xprop -notype | grep -e '^WM' -e '^_NET' -e '^_GTK' | sort"
alias lspactl-running-src="pactl list short sources | grep 'RUNNING' | cut -f 2"
alias lspactl-running-sink="pactl list short sinks | grep 'RUNNING' | cut -f 2"
# alias lsxrandr=""

# online
alias tb="nc termbin.com 9999"
alias publicip="curl ifconfig.me/ip"
alias wttr="curl wttr.in"
alias utf8-demo='curl https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# live
alias live-ssh-agent-keys='watch ssh-add -l'
alias live-tree='watch -c tree -C'
alias live-gpu='watch -n 0.1 "cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status && cat /sys/bus/pci/devices/0000:00:02.0/power/runtime_status"'

# info
alias winid="wmctrl -l | awk '/./{line=\$0} END{print \$1;}'"
alias xkeys="xev -rv | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"
# alias xkeys="xev -id (wmctrl -l | awk '/./{line=\$0} END{print \$1;}') | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"


# alias gd="e godot -o 'nvimgd init'"
# alias gdnvim="e godot -o 'nvimgd init_nvim'"
# alias gdgodot="e godot -o 'godot -e'"
# alias gdgodot="e godot -o 'devour godot -e'"
# alias gdplay="e godot -o godot"
# alias gitc="$EDITOR $XDG_CONFIG_HOME/git/config"
alias profc="$EDITOR ~/.profile"
alias xprofc="$EDITOR ~/.xprofile"

alias nvims='nvim -c "SessionLoad"'
alias nvimsw='watch -n 0.1 -c "cat .venom.json | jq -C"'
alias nvimses='sudo -E nvim -c "SessionLoad"'
alias nvim-clear='rm -rf ~/.local/share/nvim; rm -rf ~/.local/state/nvim; rm -rf ~/.cache/nvim'

alias nvimc="cd $XDG_CONFIG_HOME/nvim && nvims"
alias yolkc="cd $XDG_CONFIG_HOME/yolk && nvims"
alias mozc="cd ~/.mozilla && nvims"
alias cornc="cd ~/sectors/nvim/corn.nvim && nvims"
alias hexc="cd ~/sectors/nvim/hex.nvim && nvims"
alias rofic="cd $XDG_CONFIG_HOME/rofi && nvims"
alias nvimt="cd $XDG_CONFIG_HOME/nvim.test && NVIM_APPNAME=nvim.test nvims"
alias sshc="cd $HOME/.ssh && nvims"
alias fishc="cd $XDG_CONFIG_HOME/fish && nvims"
alias x11c="cd $XDG_CONFIG_HOME/x11/ && nvims"
alias bootc="cd /boot && nvimses"
alias xorgc="cd /etc/X11/xorg.conf.d && nvimses"
alias gitc="nvim $XDG_CONFIG_HOME/git/config $XDG_CONFIG_HOME/git/.gitconfig"
alias lazybarc="nvim $XDG_CONFIG_HOME/lazybar/config.toml"
alias hlwmc="nvim $XDG_CONFIG_HOME/herbstluftwm/autostart"
alias tmuxc="cd $XDG_CONFIG_HOME/tmux/ && nvims"
alias bins="cd ~/.local/bin && nvims"
alias notes="cd ~/files/docs/notes && nvims"
alias boots="cd /boot && nvimses"
alias gtkc='nvim $XDG_CONFIG_HOME/gtk-2.0/gtkrc $XDG_CONFIG_HOME/gtk-3.0/settings.ini $XDG_CONFIG_HOME/gtk-4.0/settings.ini'
alias qtc='nvim $XDG_CONFIG_HOME/qt5ct/qt5ct.conf $XDG_CONFIG_HOME/qt6ct/qt6ct.conf'
alias dunstc='nvim $XDG_CONFIG_HOME/dunst/dunstrc'

# alias gtk_inspect='GTK_DEBUG=interactive '

# improved aliases
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c'
alias fdisk='fdisk --color=auto'
alias free='free -h'
alias tree='tree -C'
alias du='du -h'
# alias less="$LESSPAGER"
alias echo='echo -n'
alias rg='rg --hidden'
alias lsblk="lsblk -o NAME,FSTYPE,FSSIZE,FSAVAIL,FSUSE%,MOUNTPOINT,LABEL"
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'

# XDG base dir compliance aliases
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias irssi="irssi --config=$XDG_CONFIG_HOME/irssi/config --home=$XDG_DATA_HOME/irssi"
# alias yarn="yarn --use-yarnrc '$XDG_CONFIG_HOME/yarn/config'"

# finds
alias find-node-modules="find . -name 'node_modules' -type d -prune -print | xargs du -chs"
alias find-and-clean-node-modules="find . -name 'node_modules' -type d -prune -print -exec gio trash '{}' \;"
# alias pkgfile-update='sudo pkgfile -u'

# pacman
# alias pac-info='paru -Qsq | fzf | xargs paru -Qi'
# alias pac-files='paru -Qsq | fzf | xargs paru -Ql'
# alias pac-pkgbuild='paru -Qsq | fzf | xargs paru -Gp'
alias pac-clean='sudo pacman -Rns (pacman -Qtdq)'
alias pac-uncache='sudo rm -rf /var/cache/pacman/pkg/download-*'
alias pac-sort-mirrors="curl -s 'https://archlinux.org/mirrorlist/?country=TR&country=DE&use_mirror_status=on' | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -v -n 8 - > /etc/pacman.d/mirrorlist"
# cat m | rankmirrors -v -p -r "community" -
alias pac-diff='DIFFPROG="nvim -d $1" sudo -E pacdiff'
alias pac-unlock='sudo rm /var/lib/pacman/db.lck'

# launchers
alias yt-audio='yt-dlp --extract-audio -f bestaudio'
alias yt-video='yt-dlp -f bestvideo+bestaudio'
# alias get-video='youtube-dl -f best '
# alias screen_key='screenkey -s small -p fixed -g 500x80+1420+1000 --opacity .5 --font Terminus --no-systray -t 0.5'
# alias nv='devour neovide --multiGrid --disowned'
# alias xe='Xephyr -br -ac -noreset -screen 1900x1000 :2'
# alias xe-run='DISPLAY=:2'
# alias x11vnc='x11vnc -nevershared -xkb -wait 20 -noxdamage -forever -noxcomposite -rfbauth ~/.config/x11/x11vnc_pass'
# alias x11vnc-set-pass='x11vnc -storepasswd .config/x11/x11vnc_pass'
# alias cava-mpd='cava -p ~/.config/cava/config_mpd'

# python
alias py-install-req='pip install -r requirements.txt'
alias py-activate-env='source venv/bin/activate.fish'
alias py-create-env='python -m venv ./venv'
# alias pip-make-all-req='pip freeze > requirements.txt'
# alias pip-fzf='pip list - | fzf'
# alias pip-self-update='python -m pip install --upgrade pip'
# alias pnpm-update='npm add -g pnpm'

# network misc
alias nmovpn='nmcli connection import type openvpn file'
alias nmwg='nmcli connection import type wireguard file'
alias mullvad-check='curl https://am.i.mullvad.net/connected'

# misc
alias services='systemctl list-unit-files --type service --no-pager'
alias wip='watch -n 0.1 -c ip -c -br a'
alias wblk='watch -n 0.1 -c lsblk'
alias xx='~/.xprofile'

alias fl='QT_QPA_PLATFORMTHEME=gtk sudo -E devour filelight'

if test (command -v lsd)
  alias ls='lsd'
else if test (command -v exa)
  alias ls='exa'
end

if test (command -v advcp)
  alias cp='advcp -g'
end

if test (command -v advmv)
  alias mv='advmv -g'
end

if test (command -v fd)
  alias find='fd'
end

if test (command -v herbstclient)
  alias hc='herbstclient'
end

# if test (command -v duf)
#   alias df='duf -hide special'
# end
