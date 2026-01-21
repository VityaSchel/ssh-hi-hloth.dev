#!/bin/dash

screens_dir="$(dirname "$0")/../screens"
projects="foo bar"

. "$(dirname "$0")/utils.sh"

in_list() {
	local needle="$1"
	local list="$2"

	for item in $list; do
		[ "$item" = "$needle" ] && return 0
	done
	return 1
}

show_screen() {
	screen_file="$screens_dir/$1.sh"
	if [ -f "$screen_file" ]; then
		sh "$screen_file"
	else
		echo "$(red "[Error]") Screen not found: $1"
	fi
}

show_prompt() {
	local path="~"

	case "$current_screen" in
	main)
		path="~"
		;;
	projects)
		path="~/projects"
		;;
	projects/*)
		path="~/${current_screen}"
		;;
	esac

	printf "$(green "hi@hloth.dev"):$(blue "$path")$ "
}

current_screen="main"

if [ -f "$screens_dir/greeting.sh" ]; then
	sh "$screens_dir/greeting.sh"
	echo ""
fi

show_screen "$current_screen"

while show_prompt && IFS= read -r cmd; do
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
				echo "$(red "[Error]") Command not found: $cmd"
				show_screen "help"
				;;
			esac
			;;
		projects)
			if in_list "$cmd" "$projects"; then
				current_screen="projects/$cmd"
				show_screen "$current_screen"
			elif [ "$cmd" = "back" ]; then
				current_screen="main"
				show_screen "$current_screen"
			else
				echo "$(red "[Error]") Command not found: $cmd"
				show_screen "projects"
			fi
			;;
		projects/*)
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
