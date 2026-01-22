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

link() {
	local text="$1"
	local url="$2"
	printf "\033]8;;${url}\033\\${text}\033]8;;\033\\"
}

show_nav() {
	echo "To return type '$(yellow back)' or '..'."
	echo "To leave type '$(red exit)' or press ^C."
}
