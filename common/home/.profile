#! /bin/sh

# function appendpath
#     set PATH $PATH:$1
# end

# appendpath $HOME/bin

# execute .bashrc if it exists
# [[ -f ~/.bashrc ]] && . ~/.bashrc


# prompt
PS1='\u \w | '
# eval "$(starship init bash)"

# finds binaries in $PATH
fbin() {
  echo `command -v $1`
}

append_path() {
  export PATH=$PATH:$1
}

prepend_path() {
  export PATH=$1:$PATH
}

# fail safes
export USER=${USER:-`whoami`}
export HOME=${HOME:-"/home/$USER"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.local/cache"}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME/.local/state/"}
# append_path $HOME/.local/bin
prepend_path $HOME/.local/bin
export DOTS=~/dots
# more xdg support
export XDG_DATA_DIRS=/usr/local/share:/usr/share
# export XDG_DATA_DIRS=/usr/local/share:/usr/share:~/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share

# android
# export ANDROID_HOME=$HOME/android
# append_path $ANDROID_HOME/cmdline-tools/tools/bin
# append_path $ANDROID_HOME/emulator
# append_path $ANDROID_HOME/platform-tools

# env
export SHELL=`fbin bash`
# export TERM="xterm-256color"
# export TERM="xst-256color"
export AUR_HELPER=`fbin paru`
export TERM_SHELL=`fbin fish`
export EDITOR=`fbin nvim`
export VISUAL=$EDITOR
# export PAGER=`fbin nvim`
export PAGER=`fbin less`
export MANPAGER="`fbin nvim` +Man!"
export PARU_PAGER="`fbin nvim` +Man!"
# export GIT_PAGER="`fbin nvim` +AnsiEsc"
# export GIT_PAGER=`fbin less`
# export GIT_PAGER=`fbin less -r`
export LESS="-F -X $LESS"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export TERMINAL=`fbin xst`
# export TERMINAL=`fbin kitty`
export FM=`fbin pcmanfm`
export READER=`fbin zathura`
export BROWSER=`fbin firefox`
export LAUNCHER="`fbin rofi` -show drun"
export AUDIO_MIXER=`fbin pavucontrol`
export MUSIC_CLIENT="$TERMINAL -e `fbin ncmpcpp`"
export MUSIC_SERVER=`fbin mpd`
export SCREENSHOT=`fbin scrscn`
# export SXHKD_SHELL=$SHELL
export COLOR_PICKER=`fbin color-picker`
export SYSMON=`fbin btop`

# telegram
# export QT_QPA_PLATFORMTHEME=gtk3
# export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORMTHEME=gtk2
# export TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY=1
# export TDESKTOP_DISABLE_DESKTOP_FILE_GENERATION=1

# java
export _JAVA_AWT_WM_NONREPARENTING=1

# unclutter home
export HISTSIZE=0
export LESSHISTFILE=-
export XAUTHORITY=/tmp/Xauthority
export GTK_RC_FILES=$XDG_CONFIG_HOME/gtk-1.0/gtkrc
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
export PARALLEL_HOME=$XDG_CONFIG_HOME/parallel
export XINITRC=$XDG_CONFIG_HOME/x11/xinitrc
export ICEAUTHORITY=$XDG_CACHE_HOME/ICEauthority
# export GNUPGHOME=$XDG_DATA_HOME/gnupg
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export npm_config_prefix=$HOME/.local
export NODE_REPL_HISTORY=$XDG_CACHE_HOME/node_repl_history
export NPM_HOME=$XDG_DATA_HOME/npm
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
export GOPATH="$XDG_DATA_HOME"/go
# export RUST_SRC_PATH=$RUSTUP_HOME/toolchains/nightly-$(uname -m)-unknown-linux-gnu/lib/rustlib/src/rust/src

# Autostart tbsm on tty 1
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  startx $XINITRC
else
  # setfont /usr/share/kbd/consolefonts/ter-v18n.psf.gz
  clear
  exec fish -C 'logo'
fi
