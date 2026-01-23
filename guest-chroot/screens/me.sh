#!/bin/dash
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
. "$ROOT_DIR/bin/utils.sh"

set_tab_title "hloth.dev/me"
set_tab_color 32 124 193
echo "Subpages: $(bold about)"
