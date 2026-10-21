#!/bin/dash
ROOT_DIR="${ROOT_DIR:-$(dirname "$0")/..}"
. "$ROOT_DIR/bin/utils.sh"
VIDEOS_SCRIPT_DIR="$ROOT_DIR/assets"

play_video() {
	local video="$1"
	case "$video" in
	bad_apple)
		chafa \
			--size=60x45 \
			"$VIDEOS_SCRIPT_DIR/bad_apple.gif" \
			--work 1 \
			--probe off \
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
			--size=60x45 \
			"$VIDEOS_SCRIPT_DIR/bmo.gif" \
			--work 1 \
			--probe off \
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
	zan)
		chafa \
			--size=60x60 \
			"$VIDEOS_SCRIPT_DIR/thatguyzan.gif" \
			--work 1 \
			--probe off \
			--threads 1 \
			--colors full \
			--optimize 9 \
			--fill=imported \
			--preprocess off \
			--clear \
			--dither diffusion
		;;
	skyrim)
		chafa \
			--size=60x60 \
			"$VIDEOS_SCRIPT_DIR/skyrim_skeleton.gif" \
			--work 1 \
			--probe off \
			--threads 1 \
			--colors full \
			--optimize 9 \
			--symbols=vhalf \
			--preprocess off \
			--clear \
			--dither diffusion \
			--speed 30fps
		;;
	purple_guy)
		chafa \
			"$VIDEOS_SCRIPT_DIR/purple_guy.gif" \
			--work 1 \
			--probe off \
			--threads 1 \
			--colors full \
			--optimize 9 \
			--symbols=vhalf \
			--preprocess off \
			--clear \
			--dither diffusion \
			--speed 16fps -t 1 \
			--align mid,mid \
			--bg black \
			--fg white
		;;
	jerma985)
		chafa "$VIDEOS_SCRIPT_DIR/jerma985.gif" \
			--work 1 \
			--probe off \
			--threads 1 \
			--colors full \
			--optimize 9 \
			--preprocess off \
			--clear \
			--dither diffusion \
			--speed 30fps \
			--colors full \
			--size 80xauto
		;;
	sillycat)
		chafa "$VIDEOS_SCRIPT_DIR/sillycat.gif" \
			--work 1 \
			--probe off \
			--threads 1 \
			--colors full \
			--optimize 9 \
			-t 0.72 \
			--clear \
			--size 100xauto \
			--symbols vhalf \
			--format symbols
		;;
	*)
		echo "$(red "[Error]") Video not found: $video"
		;;
	esac
}
