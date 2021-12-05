#!/usr/bin/bash

wid=$1
class_name=$2
instance_name=$3
consequences=$4

function instance_name() {
    [ "$instance_name" = "$1" ] && return 0 || return 1
}

function instance_name_starts_with() {
    [[ "$instance_name" = $1* ]] && return 0 || return 1
}

function class_name() {
    [ "$class_name" = "$1" ] && return 0 || return 1
}

function class_name_starts_with() {
    [[ "$class_name" = $1* ]] && return 0 || return 1
}

function window_role() {
    [`$(xprop -id $wid WM_WINDOW_ROLE | awk -F '"' '{print $2}')` = "$1" ] && return 0 || return 1
}

function window_name() {
    [ "$(xdotool getwindowname $wid)" = "$1" ] && return 0 || return 1
}

instance_name "vlc" && window_name "vlc" && echo "layer=above"
instance_name "chromium" && window_role "pop-up" && echo "state=floating center=on"
window_name "win0" && class_name_starts_with "jetbrains" && echo "state=floating"
class_name "Zathura" && echo "state=tiled"
class_name "Emacs" && echo "state=tiled"
class_name "Godot_Engine" && echo "state=floating"
# class_name "telegram-desktop" && ! instance_name_starts_with "Telegram" && echo "state=floating"
# class_name "telegram-desktop" && ! window_name "Telegram (4502)" && echo "state=floating"

# class = "telegram-desktop"
# name must not start with "Telegram"

# window_name "Media Viewer" && class_name "telegram-desktop" && echo "state=floating"
# window_name "Media Viewer" && class_name "telegram-desktop" && echo "state=floating"
# window_name "Media Viewer" && echo "state=floating"
# class_name "TelegramDesktop" && echo "state=floating"
window_name "FloatMe" && echo "state=floating"

class_name "Steam" && echo "state=floating"
class_name "Steam" && window_name "Steam" && echo "state=tiled"

# windows steam
window_name "Friends List" && echo "state=float"

class_name "scratchterm" && echo "sticky=on state=fullscreen hidden=on"
# bspc rule -a scratchterm sticky=on state=floating hidden=on

# class_name_starts_with "st-" && echo "state=floating hidden=on"

#class_name_starts_with "eww" && echo "state=floating"

#TODO: extract rectangle into an xdotool auto calculation based on current monitor (resolution - (bspwm_border_w*2))
#class_name "st-256color" && window_name "xst_dropdown_full" && echo "sticky=on state=floating rectangle=1918x1078+0+0"
#class_name "st-256color" && window_name "xst_dropdown_top" && echo "sticky=on state=floating rectangle=1918x539+0+0"
#class_name "st-256color" && window_name "xst_dropdown_left" && echo "sticky=on state=floating rectangle=659x1078+0+0"
