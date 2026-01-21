#!/bin/sh

screens_dir="$(dirname "$0")/../screens"

show_screen() {
	screen_file="$screens_dir/$1.txt"
	if [ -f "$screen_file" ]; then
		cat "$screen_file"
	else
		echo "[Error] Screen not found: $1"
	fi
}

current_screen="main"
show_screen "$current_screen"

while IFS= read -r cmd; do
	case "$cmd" in
	exit)
		break
		;;
	"") ;;
	*)
		case "$current_screen" in
		main)
			case "$cmd" in
			help)
				show_screen "help"
				;;
			about)
				show_screen "about"
				;;
			projects)
				current_screen="projects"
				show_screen "$current_screen"
				;;
			*)
				echo "[Error] Command not found: $cmd"
				show_screen "help"
				;;
			esac
			;;
		projects)
			case "$cmd" in
			back)
				current_screen="main"
				show_screen "$current_screen"
				;;
			"foo")
				current_screen="projects/foo"
				show_screen "$current_screen"
				;;
			"bar")
				current_screen="projects/bar"
				show_screen "$current_screen"
				;;
			*)
				echo "[Error] Command not found: $cmd"
				show_screen "projects"
				;;
			esac
			;;
		projects/foo | projects/bar)
			case "$cmd" in
			back)
				current_screen="projects"
				show_screen "$current_screen"
				;;
			*)
				echo "Command not found: $cmd"
				echo "Type 'back' or 'exit'."
				;;
			esac
			;;
		*)
			current_screen="main"
			show_screen "$current_screen"
			;;
		esac
		;;
	esac
done
