#!/bin/dash

VIDEOS_SCRIPT_DIR="$(dirname "$0")"

play_video() {
	local video="$1"
	case "$video" in
	bad_apple)
		chafa \
			--size=60x45 \
			"$VIDEOS_SCRIPT_DIR/../assets/bad_apple.gif" \
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
	bmo)
		chafa \
			--size=60x45 "$VIDEOS_SCRIPT_DIR/../assets/bmo.gif" \
			--work 1 \
			--threads 1 \
			--colors 256 \
			--optimize 9 \
			--fill=ascii \
			--fg-only \
			--symbols=braille \
			--preprocess off \
			--clear \
			--fg white \
			--dither diffusion
		;;
	*)
		echo "$(red "[Error]") Video not found: $video"
		;;
	esac
}
