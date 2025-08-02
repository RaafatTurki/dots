#!/usr/bin/env bash

# execute .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

# finds binaries in $PATH
bin_path() {
  command -v "$1"
}

# NOTE: use this instead of append_path
# append_path () {
#     case ":$PATH:" in
#         *:"$1":*)
#             ;;
#         *)
#             PATH="${PATH:+$PATH:}$1"
#     esac
# }


append_path() {
  export PATH=$PATH:$1
}

prepend_path() {
  export PATH=$1:$PATH
}

append_manpath() {
  export MANPATH=$MANPATH:$1
}

append_infopath() {
  export INFOPATH=$INFOPATH:$1
}

# export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/amd_pro_icd64.json

# fail safes
export USER=${USER:-$(whoami)}
export HOME=${HOME:-"/home/$USER"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME/.local/state/"}
export XDG_SESSION_TYPE=x11

export XDG_CURRENT_DESKTOP=X-Generic
export DE=generic
# export XDG_SESSION_DESKTOP= # stays unset for wms

export GTK_USE_PORTAL=1
export GDK_DEBUG=portals

append_path "$HOME/.local/bin"
append_path "$HOME/.local/share/cargo/bin/"
append_path "$HOME/.local/share/go/bin/"
append_path "$HOME/.luarocks/bin/"
append_path "$XDG_CONFIG_HOME/luarocks/bin/"
append_path "$XDG_CONFIG_HOME/composer/vendor/bin/"

# more xdg support
export XDG_DATA_DIRS=/usr/local/share:/usr/share
# export XDG_DATA_DIRS=/usr/local/share:/usr/share:~/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share

# android
# export ANDROID_HOME="$HOME/.android/android-sdk"
# export ANDROID_SDK_ROOT="$HOME/.android/android-sdk"
# export ANDROID_NDK="$HOME/.android/android-ndk"
# append_path "$ANDROID_SDK_ROOT/emulator"
# append_path "$ANDROID_SDK_ROOT/platform-tools"
# append_path "$HOME/.dotnet/tools"

# pnpm
# export PNPM_HOME="$XDG_DATA_HOME/pnpm"
# append_path "$PNPM_HOME"

# bun
append_path "$XDG_CACHE_HOME/.bun/bin"

# rofi scripts
append_path "$XDG_CONFIG_HOME/rofi/scripts"

# encore
export ENCORE_INSTALL="/home/potato/.encore"
append_path "$ENCORE_INSTALL/bin"


# env
export SHELL=$(bin_path bash)
export AUR_HELPER=$(bin_path paru)
export EDITOR=$(bin_path nvim)
export SYSTEMD_EDITOR=$(bin_path nvim)
export VISUAL=$EDITOR
# export LESSPAGER="$(bin_path less) -R -S -X -e"
export LESSPAGER="$(bin_path less)"
export PAGER="$LESSPAGER"
export MANPAGER="$(bin_path nvim) +Man!"
export PARU_PAGER="$(bin_path nvim) +Man!"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export TERMINAL=$(bin_path st)
export TERMINAL_SHELL=$(bin_path fish) # NOTE: CUSTOM
export FM=$(bin_path thunar)
export READER=$(bin_path zathura)
export BROWSER=$(bin_path firefox)
export SCREENSHOT=$(bin_path sshot)
export COLOR_PICKER=$(bin_path cpick)

# theming
# export XCURSOR_THEME=Yaru
# export GTK_THEME=Yaru-blue-dark
# export XDG_CURRENT_DESKTOP=gtk
# export QT_STYLE_OVERRIDE=adwaita-dark

# qt
export QT_QPA_PLATFORMTHEME=gtk3
# export QT_QPA_PLATFORMTHEME=qt5ct
# export QT_QPA_PLATFORMTHEME=qt6ct
# export QT_QPA_PLATFORMTHEME=gtk2
# export TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY=1
# export TDESKTOP_DISABLE_DESKTOP_FILE_GENERATION=1

# c#
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# java
export _JAVA_AWT_WM_NONREPARENTING=1

# nemo
# export GNOME22_USER_DIR="$HOME/.config/nemo"

# lua
export LUA_PATH='/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/potato/.luarocks/share/lua/5.4/?.lua;/home/potato/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/lib/lua/5.4/?.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/potato/.luarocks/lib/lua/5.4/?.so'

# unclutter home
export HISTFILE="$XDG_DATA_HOME/bash_history"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GTK_RC_FILES=$XDG_CONFIG_HOME/gtk-1.0/gtkrc
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
export PARALLEL_HOME=$XDG_CONFIG_HOME/parallel
export XINITRC=$XDG_CONFIG_HOME/x11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/x11/xserverrc
export ICEAUTHORITY=$XDG_CACHE_HOME/ICEauthority
# export GNUPGHOME=$XDG_CONFIG_HOME/gnupg
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export npm_config_prefix=$HOME/.local
export VALKEYCLI_HISTFILE=$XDG_DATA_HOME/valkeycli_history
export NODE_REPL_HISTORY=$XDG_DATA_HOME/node_repl_history
export NPM_HOME=$XDG_DATA_HOME/npm
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
export GOPATH=$XDG_DATA_HOME/go
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export OMNISHARPHOME="$XDG_CONFIG_HOME"/omnisharp
export W3M_DIR="$XDG_DATA_HOME"/w3m
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/ripgreprc
# export RUST_SRC_PATH=$RUSTUP_HOME/toolchains/nightly-$(uname -m)-unknown-linux-gnu/lib/rustlib/src/rust/src

export GSK_RENDERER=gl
export GDK_DEBUG=gl-no-fractional

# activate gtk3 no csd if available
GTK3_NO_CSD_SO=/usr/lib/libgtk-nocsd.so.0
if [ -e $GTK3_NO_CSD_SO ]; then
  export GTK_CSD=0
  export LD_PRELOAD=$GTK3_NO_CSD_SO
fi

# eliminate the staircase effect
stty onlcr

# xinit on tty 1 and dennis on others
if [ "${XDG_VTNR}" -eq 1 ]; then
  # no exec because we want to keep the tty console alive
  xinit
else
  # setfont /usr/share/kbd/consolefonts/ter-v18n.psf.gz
  clear
  exec fish -C 'dennis'
fi
