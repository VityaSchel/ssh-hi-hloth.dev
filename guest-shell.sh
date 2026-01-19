#!/bin/sh

WELCOME="Welcome guest. Type 'help' to see available commands."
ABOUT="This is a restricted guest shell."

echo "$WELCOME"

while :; do
  printf '> ' 2>/dev/null || :
  IFS= read -r cmd || break

  case "$cmd" in
    help)
      echo "Available commands:"
      echo "  help  - show this help"
      echo "  about - show info"
      echo "  exit  - leave"
      ;;
    about)
      echo "$ABOUT"
      ;;
    exit)
      break
      ;;
    "")
      ;;
    *)
      echo "Command not found: $cmd"
      echo "Type 'help' to see available commands."
      ;;
  esac
done