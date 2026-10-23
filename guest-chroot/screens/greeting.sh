#!/bin/dash
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
. "$ROOT_DIR/bin/utils.sh"

echo ""

chafa \
	--threads 1 \
	--size=32x32 \
	--view-size=50x10 \
	--dither diffusion \
	"$(dirname "$0")/../assets/me.png" \
	--align mid,bottom \
	--margin-bottom 0 \
	-t 1 \
	--bg black \
	--colors full

. "$ROOT_DIR/bin/card.sh"

echo "\r$(green "Welcome to the guest shell of my production server!")"
