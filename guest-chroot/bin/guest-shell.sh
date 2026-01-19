#!/bin/sh

echo "Welcome guest. Type 'help' to see available commands."

while IFS= read -r cmd; do
  case "$cmd" in
    help)
      echo "Available commands: help, about, exit"
      ;;
    about)
      echo "This is a restricted guest shell."
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