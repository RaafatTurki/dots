# avim: syntax=sh

if status is-interactive

  # General
  set fish_greeting
  # starship init fish | source
  # zoxide init fish | source
  # set python_auto_venv

  # Init
  # venv_auto


  # ALIASES
  alias s="sudo"
  alias ss="sudo -E"
  alias x="chmod +x"
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
  alias lsdu='du -ahx -- * | sort -rh | head -10'
  # alias lsdu='du -ahx -- .* | sort -rh | head -10'
  # alias once="execute -o -c"
  # alias reload="execute -r -c"
  alias get-display-size='xdpyinfo | grep -B 2 resolution'
  alias get-mime='xdg-mime query filetype'
  alias journal-boot='sudo journalctl -p 3 -b --no-pager'
  # alias hx='helix'

  # live aliases
  alias live='watch -c -w -t -n 0.1'
  alias live-ssh-agent-keys='watch ssh-add -l'
  # alias live-tree='watch tree -C'

  # alias wine-install="aa -S wine-staging && aa -S --needed --asdeps (pacman -Si wine-staging | sed -n '/^Opt/,/^Conf/p' | sed '$d' | sed 's/^Opt.*://g' | sed 's/^\s*//g')"
  alias get_active_src="pactl list sources | grep -A 3 RUNNING | grep Name | cut -d ' ' -f 2"
  alias get_active_sink="pactl list sinks | grep -A 3 RUNNING | grep Name | cut -d ' ' -f 2"
  alias utf8_test='curl https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt'
  alias benchmark='hyperfine'
  alias kssh='kitty +kitten ssh'

  # e aliases
  alias nvimp="e nvimp -q"
  alias nvims="e nvims -q"
  complete -f -c nvims -a (find "$XDG_DATA_HOME/nvim/sessions/" -printf '%P ')

  alias notes="e notes -q"
  alias bins="e bin -q"
  alias wines="e wines -q"

  alias nvimc="e nvims -q nvimc"
  alias fishc="e nvims -q fishc"
  # alias nvimc="e nvimc -o 'devour neovide' -q"
  # alias gd="e godot -o 'nvimgd init'"
  # alias gdnvim="e godot -o 'nvimgd init_nvim'"
  # alias gdgodot="e godot -o 'godot -e'"
  # alias gdgodot="e godot -o 'devour godot -e'"
  # alias gdplay="e godot -o godot"
  alias gitc="$EDITOR $XDG_CONFIG_HOME/git/config"
  alias profc="$EDITOR ~/.profile"

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
  alias cp='cp -i'
  alias mv='mv -i'
  alias rm='rm -i'
  alias less='less -r'
  alias echo='echo -n'
  alias rg='rg --hidden'

  # XDG compliance aliases
  alias yarn="yarn --use-yarnrc '$XDG_CONFIG_HOME/yarn/config'"
  alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
  alias irssi="irssi --config=$XDG_CONFIG_HOME/irssi/config --home=$XDG_DATA_HOME/irssi"

  # utils
  alias pkgfile-update='sudo pkgfile -u'
  alias node_modules_find="find . -name 'node_modules' -type d -prune -print | xargs du -chs"
  alias node_modules_clean="find . -name 'node_modules' -type d -prune -print -exec trash -r '{}' \;"
  alias lib32-find="aa -Qsq | grep lib32 | fzf | xargs pacman -Qi"
  alias kernel-params="cat /proc/cmdline"
  alias key="xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"

  # pacman
  alias pac-info='paru -Qsq | fzf | xargs paru -Qi'
  alias pac-files='paru -Qsq | fzf | xargs paru -Ql'
  alias pac-pkgbuild='paru -Qsq | fzf | xargs paru -Gp'
  alias pac-clean='sudo pacman -Rns (pacman -Qtdq)'
  alias pac-sort-mirrors="curl -s 'https://archlinux.org/mirrorlist/?country=TR&country=DE&use_mirror_status=on' | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -v -n 8 - > /etc/pacman.d/mirrorlist"

  # launchers
  alias get-audio='youtube-dl --extract-audio -f bestaudio'
  alias get-video='youtube-dl -f bestvideo+bestaudio'
  # alias get-video='youtube-dl -f best '
  alias nv='devour neovide --multiGrid --disowned'
  # alias screen_key='screenkey -s small -p fixed -g 500x80+1420+1000 --opacity .5 --font Terminus --no-systray -t 0.5'
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

  # android
  alias create-android-debugstore='keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android -keystore debug.keystore -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999 -deststoretype pkcs12'














  # relocate into actual scrscn sourcecode
  complete -c scrscn -f
  complete -c scrscn -a 'clip' -d 'Take a screenshot and save it into clipboard'
  complete -c scrscn -a 'save' -d 'Take a screenshot and save into ~/Pictures/screenshots'
  complete -c scrscn -a 'decode' -d 'Take a screenshot and save its decoded content into clipboard (qrcodes and barcodes)'
  complete -c scrscn -a 'help' -d 'Print a short help text and exit'
end

# pnpm
set -gx PNPM_HOME "/home/potato/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
