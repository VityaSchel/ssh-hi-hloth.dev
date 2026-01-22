#!/bin/dash

screens_dir="$(dirname "$0")/../screens"
showcase=$(cd "$screens_dir" && ls -1 showcase/ 2>/dev/null | sed 's/\.sh$//' | tr '\n' ' ' | sed 's/ $//')
me=$(cd "$screens_dir" && ls -1 me/ 2>/dev/null | sed 's/\.sh$//' | tr '\n' ' ' | sed 's/ $//')

. "$(dirname "$0")/utils.sh"

in_list() {
	local needle="$1"
	local list="$2"

	for item in $list; do
		[ "$item" = "$needle" ] && return 0
	done
	return 1
}

sanitize_input() {
	local input="$1"
	local output=""
	local char
	local i=0
	local len=${#input}

	while [ $i -lt $len ]; do
		char="${input%"${input#?}"}"
		input="${input#?}"
		case "$char" in
		[\ -~]) output="${output}${char}" ;;
		esac
		i=$((i + 1))
	done

	printf '%s' "$output"
}

show_screen() {
	screen_file="$screens_dir/$1.sh"
	if [ -f "$screen_file" ]; then
		sh "$screen_file"
	else
		echo "$(red "[Error]") Screen not found: $1"
	fi
}

go_to() {
	current_screen="$1"
	show_screen "$current_screen"
}

show_prompt() {
	local path="~"

	case "$current_screen" in
	main)
		path="~"
		;;
	*)
		path="~/${current_screen}"
		;;
	esac

	printf "$(green "hi@hloth.dev"):$(blue "$path")$ "
}

show_404() {
	printf "$(red "[Error]") Command not found: "
	printf '%s\n' "$cmd"
}

handle_directory_screen() {
	local dir_name="$1"
	local available_items="$2"

	if [ "$cmd" = "help" ]; then
		show_screen "${dir_name}/help"
	elif [ "$cmd" = "back" ] || [ "$cmd" = ".." ]; then
		go_to "main"
	elif in_list "$cmd" "$available_items"; then
		go_to "${dir_name}/$cmd"
	else
		show_404 "$cmd"
		show_screen "$dir_name"
	fi
}

handle_directory_subscreen() {
	local dir_name="$1"

	case "$cmd" in
	back | ..)
		go_to "$dir_name"
		;;
	*)
		show_404 "$cmd"
		show_nav
		;;
	esac
}

handle_exit() {
	if [ -f "$screens_dir/farewell.sh" ]; then
		sh "$screens_dir/farewell.sh"
	fi
}

handle_interrupt() {
	echo ""
}

trap handle_exit EXIT

trap handle_interrupt INT

if [ -f "$screens_dir/greeting.sh" ]; then
	sh "$screens_dir/greeting.sh"
fi

current_screen="main"

show_screen "$current_screen"

while show_prompt && IFS= read -r cmd; do
	cmd="$(sanitize_input "$cmd")"

	case "$cmd" in
	exit)
		break
		;;
	"") ;;
	*)
		case "$current_screen" in
		main)
			case "$cmd" in
			help | about | donate)
				show_screen "$cmd"
				;;
			me | showcase)
				go_to "$cmd"
				;;
			*)
				show_404 "$cmd"
				show_screen "help"
				;;
			esac
			;;
		showcase)
			handle_directory_screen "showcase" "$showcase"
			;;
		showcase/*)
			handle_directory_subscreen "showcase"
			;;
		me)
			handle_directory_screen "me" "$me"
			;;
		me/*)
			handle_directory_subscreen "me"
			;;
		*)
			go_to "main"
			;;
		esac
		;;
	esac
done
