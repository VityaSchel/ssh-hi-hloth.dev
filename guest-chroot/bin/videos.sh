#!/bin/dash

play_video() {
	local video="$1"
	case "$video" in
	bad_apple)
		chafa \
			--size=60x45 \
			"$(dirname "$0")/../assets/bad_apple.gif" \
			--work 1 \
			--threads 1 \
			--colors 2 \
			--optimize 9 \
			--fill=ascii \
			--fg-only \
			--symbols=ascii \
			--preprocess off \
			--clear \
			--fg white
		;;
	*)
		echo "$(red "[Error]") Video not found: $video"
		;;
	esac
}
