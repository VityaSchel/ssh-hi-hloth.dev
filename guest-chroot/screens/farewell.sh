#!/bin/dash
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
. "$ROOT_DIR/bin/utils.sh"

iterm_explode_fireworks
echo "$(dim "See you later! 😘")"
printf "\033]6;1;bg;*;default\a"
