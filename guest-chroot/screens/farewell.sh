#!/bin/dash
. "$(dirname "$0")/../bin/utils.sh"

iterm_explode_fireworks
echo "$(dim "See you later! 😘")"
printf "\033]6;1;bg;*;default\a"
