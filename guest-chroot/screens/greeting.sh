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

echo "╭─────────────────────────────────╮"
echo "│ $(bold "Viktor Shchelochkov")             │"
echo "│ Senior Full Stack Web Developer │"
echo "│ $(dim "20 y.o., Barcelona, Spain")       │"
echo "╰─────────────────────────────────╯"

echo "╭──────────┬──────────┬───────────╮"

echo "│$(
	link "$(bg_black "$(white " Upwork   ")")" \
		https://www.upwork.com/freelancers/~01a1f59e7a4697be89
)│$(
	link "$(bg_c256 36 "$(white " Matrix°  ")")" \
		"https://matrix.to/#/@hloth:hloth.dev"
)│$(
	link "$(bg_c256 33 "$(c256 255 " Email     ")")" \
		"mailto:hi@hloth.dev"
)│"

echo "│$(
	link "$(bg_c256 234 "$(c256 202 " Forgejo° ")")" \
		"https://git.hloth.dev/hloth"
)│$(
	link "$(bg_c256 38 "$(white " Telegram ")")" \
		"https://t.me/hlothdev"
)│$(
	link "$(bg_black "$(c256 187 " Blog      ")")" \
		"https://blog.hloth.dev"
)│"

echo "│$(
	link "$(bg_c256 25 "$(white " LinkedIn ")")" \
		"https://www.linkedin.com/in/hloth"
)│$(
	link "$(bg_c256 63 "$(white " Discord  ")")" \
		"https://discord.com/users/329249421332316166"
)│$(
	link "$(bg_c256 197 "$(c256 255 " Instagram ")")" \
		"https://instagram.com/hlothdev"
)│"

echo "╰──────────┴──────────┴───────────╯"

echo "\r$(green "Welcome to the guest shell of my production server!")"
