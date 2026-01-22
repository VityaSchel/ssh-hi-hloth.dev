#!/bin/dash

color() {
	local code="$1"
	local text="$2"
	printf "\033[${code}m${text}\033[0m"
}

bold() { color "1" "$1"; }
dim() { color "2" "$1"; }
red() { color "31" "$1"; }
green() { color "32" "$1"; }
yellow() { color "33" "$1"; }
blue() { color "34" "$1"; }
magenta() { color "35" "$1"; }
cyan() { color "36" "$1"; }
underline() { color "4" "$1"; }
black() { color "30" "$1"; }
white() { color "37" "$1"; }
bg_red() { color "41" "$1"; }
bg_green() { color "42" "$1"; }
bg_yellow() { color "43" "$1"; }
bg_blue() { color "44" "$1"; }
bg_magenta() { color "45" "$1"; }
bg_cyan() { color "46" "$1"; }
bg_black() { color "40" "$1"; }
bg_white() { color "47" "$1"; }
c256() {
	local code="$1"
	local text="$2"
	printf "\033[38;5;${code}m${text}\033[0m"
}
bg_c256() {
	local code="$1"
	local text="$2"
	printf "\033[48;5;${code}m${text}\033[0m"
}

link() {
	local text="$1"
	local url="$2"
	printf "\033]8;;${url}\033\\${text}\033]8;;\033\\"
}

show_nav() {
	echo "To return type '$(yellow back)' or '..'."
	echo "To leave type '$(red exit)' or press ^C."
}

set_tab_title() {
	printf "\033]0;%s\007" "$1"
}

set_tab_color() {
	local red="$1"
	local green="$2"
	local blue="$3"
	printf "\033]6;1;bg;red;brightness;%d\007" "$red"
	printf "\033]6;1;bg;green;brightness;%d\007" "$green"
	printf "\033]6;1;bg;blue;brightness;%d\007" "$blue"
}

send_notification() {
	local message="$1"
	printf "\033]9;%s\033\\" "$message"
}

iterm_explode_fireworks() {
	printf "\033]1337;RequestAttention=fireworks\033\\"
}

iterm_set_badge() {
	local message="$1"
	printf "\033]1337;SetBadgeFormat=%s\033\\" "$(echo -n "$message" | base64)"
}