# avim: syntax=sh

# General
set fish_greeting
# starship init fish | source
# set python_auto_venv

# Init
venv_auto


# ALIASES
alias _="sudo"
alias __="sudo -E"
alias aa="paru"
alias home="cd ~"
alias dots="cd $DOTS"
alias nivm="nvim"
alias env="env | sort"
alias neo="neofetch"
alias jctl="journalctl -p 3 -xb"
alias tb="nc termbin.com 9999"
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias path="echo $PATH | tr ':' '\n'"
alias fonts="fc-list | cut -d ':' -f 2,3 | sort | fzf | xclip -selection clipboard"
alias weather="curl wttr.in"
alias cb="xclip -selection clipboard"
alias live-tree='watch tree -C'
alias lsdu='du -ahx -- * | sort -rh | head -10'
# alias lsdu='du -ahx -- .* | sort -rh | head -10'
# alias once="execute -o -c"
# alias reload="execute -r -c"
alias get-dpi='xdpyinfo | grep -B 2 resolution'

# alias wine-install="aa -S wine-staging && aa -S --needed --asdeps (pacman -Si wine-staging | sed -n '/^Opt/,/^Conf/p' | sed '$d' | sed 's/^Opt.*://g' | sed 's/^\s*//g')"
alias get_active_src="pactl list sources | grep -A 3 RUNNING | grep Name | cut -d ' ' -f 2"
alias get_active_sink="pactl list sinks | grep -A 3 RUNNING | grep Name | cut -d ' ' -f 2"
alias utf8_test='curl https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt'
alias benchmark='hyperfine'
alias kssh='kitty +kitten ssh'

# e aliases
alias nvimc="e nvim -q"
# alias nvimc="e nvim -o 'devour neovide' -q"
alias dotc="e dots -q"
alias binc="e bin -q"
alias notec="e note -q"
alias fishc="$EDITOR $XDG_CONFIG_HOME/fish/config.fish"
alias gitc="$EDITOR $XDG_CONFIG_HOME/git/config"
alias profc="$EDITOR ~/.profile"
alias gd="e godot -o 'nvimgd init'"
alias gdnvim="e godot -o 'nvimgd init_nvim'"
# alias gdgodot="e godot -o 'godot -e'"
alias gdgodot="e godot -o 'devour godot -e'"
alias gdplay="e godot -o godot"

# alias gtk_inspect='GTK_DEBUG=interactive '

# improved aliases
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias fdisk='fdisk --color=auto'
alias df='df -h'
alias free='free -h'
alias tree='tree -C'
alias watch='watch -c'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias less='less -r'
alias echo='echo -n'

# XDG compliance aliases
alias yarn="yarn --use-yarnrc '$XDG_CONFIG_HOME/yarn/config'"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias irssi="irssi --config=$XDG_CONFIG_HOME/irssi/config --home=$XDG_DATA_HOME/irssi"

# utils
alias pkgfile-update='sudo pkgfile -u'
alias pac-unlock='sudo rm /var/lib/pacman/db.lck'
alias pac-clean='sudo pacman -Rns (pacman -Qtdq)'
alias pac-sort-mirrors="curl -s 'https://archlinux.org/mirrorlist/?country=TR&country=DE&use_mirror_status=on' | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -v -n 8 - > /etc/pacman.d/mirrorlist"
alias node_modules_find="find . -name 'node_modules' -type d -prune -print | xargs du -chs"
alias node_modules_clean="find . -name 'node_modules' -type d -prune -print -exec trash -r '{}' \;"
alias lib32_find="aa -Qsq | grep lib32 | fzf | xargs pacman -Qi"

# pacman
alias pkgi='paru -Qeq | fzf | xargs paru -Qi'
alias pkgia='paru -Qsq | fzf | xargs paru -Qi'
alias pkgp='paru -Qeq | fzf | xargs paru -Gp'
alias pkgpa='paru -Qsq | fzf | xargs paru -Gp'

# launchers
alias get-audio='youtube-dl --extract-audio -f bestaudio'
alias get-video='youtube-dl -f bestvideo+bestaudio'
# alias get-video='youtube-dl -f best '
alias nv='devour neovide --multiGrid --disowned'
alias sk='screenkey -s small -p fixed -g 500x80+1420+1000 --opacity .5 --font Terminus --no-systray -t 0.5'
alias lg='lazygit'
alias xe='Xephyr -br -ac -noreset -screen 1900x1000 :2'
alias xe-run='DISPLAY=:2'
alias x11vnc='x11vnc -nevershared -xkb -wait 20 -noxdamage -forever -noxcomposite -rfbauth ~/.config/x11/x11vnc_pass'
alias x11vnc-set-pass='x11vnc -storepasswd .config/x11/x11vnc_pass'
alias cava-mpd='cava -p ~/.config/cava/config_mpd'

# python
alias pip-install-req='pip install -r requirements.txt'
alias pip-make-all-req='pip freeze > requirements.txt'
alias pip-fzf='pip list - | fzf'
alias pip-self-update='python -m pip install --upgrade pip'
alias venv='python -m venv'


# ENV VARS
#(being set to st-256color in xrdb)

#alias mirr-score="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
#alias mirr-delay="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
#alias mirr-age="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
#alias mirr-="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

# conversion, ls/exa
#alias ls="exa --color=always --group-directories-first"
#alias la="exa -a --color=always --group-directories-first"
#alias ll="exa -l --color=always --group-directories-first"
#alias lt="exa -T --color=always --group-directories-first"

#alias npm-ls="npm list -g --depth=0"
#alias json="prettier $0 | bat -l json"

#alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify" # verify signature for isos
#alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys" # receive the key of a developer
#alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME" # bare git repo alias for dotfiles

# process
#alias ps-mem='ps auxf | sort -nr -k 4'
#alias ps-mem10='ps auxf | sort -nr -k 4 | head -10'
#alias pscpu='ps auxf | sort -nr -k 3'
#alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

#set GTK2_RC_FILES $HOME/.config/gtk-2.0/gtkrc-2.0

# -=-=-=- ENV VARS -=-=-=-
# set LIBVA_DRIVER_NAME vdpau
# set _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
# set QT_QPA_PLATFORMTHEME qt5ct
# set QT_QPA_PLATFORMTHEME gtk2
# set XDG_CURRENT_DESKTOP gnome
# set PASTEL_COLOR_MODE 24bit

#no need when using gtk mushroom
# set GTK_CSD=0
# set LD_PRELOAD=/usr/lib/libgtk3-nocsd.so.0


# -=-=-=- Ascii Greeter -=-=-=-
# Arch tulizu ascii art
# tulizu list arch-lettering-condensed show
# Auto start tbsm after login on VT 1 and 2
# [[ $XDG_VTNR -le 2 ]] && tbsm

# Auto start tbsm only on tty1
# if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
#   exec tbsm
# fi
