#!/bin/dash
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
. "$ROOT_DIR/bin/utils.sh"

set_tab_title "hloth.dev/showcase"
set_tab_color 113 32 193
echo "Projects: $(bold foo), $(bold bar)"

