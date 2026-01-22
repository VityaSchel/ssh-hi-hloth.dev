#!/bin/dash
. "$(dirname "$0")/../bin/utils.sh"

echo ""
chafa --size=32x32 --dither diffusion "$(dirname "$0")/../assets/me.png" --align left,top
echo "╭─────────────────────────────────╮"
echo "│ $(bold "Viktor Shchelochkov")             │"
echo "│ Senior Full Stack Web Developer │"
echo "│ $(dim "20 y.o., Barcelona, Spain")       │"
echo "╰─────────────────────────────────╯"
echo "\r$(green "Welcome to the guest shell of my production server!")"
