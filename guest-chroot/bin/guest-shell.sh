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
			help)
				show_screen "help"
				;;
			about)
				show_screen "about"
				;;
			me)
				current_screen="me"
				show_screen "$current_screen"
				;;
			donate)
				show_screen "donate"
				;;
			showcase)
				current_screen="showcase"
				show_screen "$current_screen"
				;;
			*)
				echo "$(red "[Error]") Command not found: $cmd"
				show_screen "help"
				;;
			esac
			;;
		showcase)
			if in_list "$cmd" "$showcase"; then
				current_screen="showcase/$cmd"
				show_screen "$current_screen"
			elif [ "$cmd" = "back" ]; then
				current_screen="main"
				show_screen "$current_screen"
			else
				printf "$(red "[Error]") Command not found: "
				printf '%s\n' "$cmd"
				show_screen "showcase"
			fi
			;;
		showcase/*)
			case "$cmd" in
			back)
				current_screen="showcase"
				show_screen "$current_screen"
				;;
			*)
				echo "Command not found: $cmd"
				echo "Type 'back' or 'exit'."
				;;
			esac
			;;
		me)
			if in_list "$cmd" "$me"; then
				current_screen="me/$cmd"
				show_screen "$current_screen"
			elif [ "$cmd" = "back" ]; then
				current_screen="main"
				show_screen "$current_screen"
			else
				printf "$(red "[Error]") Command not found: "
				printf '%s\n' "$cmd"
				show_screen "me"
			fi
			;;
		me/*)
			case "$cmd" in
			back)
				current_screen="me"
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
