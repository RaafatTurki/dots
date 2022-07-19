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
window_name "Welcome to IntelliJ IDEA" && echo "state=floating"
window_name "Welcome to Brave" && echo "state=floating"
window_name "Execute File" && echo "state=floating"

window_role "pop-up" && echo "state=floating center=on"

class_name "Zathura" && echo "state=tiled"
class_name "Emacs" && echo "state=tiled"
class_name "Godot_Engine" && echo "state=floating"
class_name "Ice" && echo "state=floating"
class_name "Steam" && echo "state=floating"
class_name "pentablet" && echo "state=floating"
class_name "Steam" && window_name "Steam" && echo "state=tiled"
class_name "xpad" && echo "state=floating"
class_name "Toplevel" && echo "state=floating"
class_name "fontforge" && echo "state=floating"

# class_name "firefox" && echo "layer=below"
# window_name "panel" && echo "layer=above"

# window_name "Open with" && echo "state=tiled"
# class_name "nemo" && 
# state=floating rectangle="1000x1000+0+0" center=true

# debug
window_name "float_me" && echo "state=floating"
