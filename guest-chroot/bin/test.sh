#!/bin/sh
# Get iTerm2 background color using OSC 4 sequence

# Send the query for background color (-2)
# OSC is \033], ST is \033\\
printf '\033]4;-2;?\033\\'

# Read the response
# The terminal will respond with: OSC 4 ; -2 ; rgb:RRRR/GGGG/BBBB ST
IFS='' read -r -d '\' response

# Parse the RGB values from the response
# Response format: ]4;-2;rgb:RRRR/GGGG/BBBB
rgb_part=$(echo "$response" | sed -n 's/.*rgb:\([^\\]*\).*/\1/p')

if [ -n "$rgb_part" ]; then
    # Extract R, G, B components
    red=$(echo "$rgb_part" | cut -d'/' -f1)
    green=$(echo "$rgb_part" | cut -d'/' -f2)
    blue=$(echo "$rgb_part" | cut -d'/' -f3)
    
    echo "Background color (hex):"
    echo "  Red:   $red"
    echo "  Green: $green"
    echo "  Blue:  $blue"
    
    # Convert to 2-digit hex if needed (take first 2 chars of 4-digit values)
    red_2d=$(echo "$red" | cut -c1-2)
    green_2d=$(echo "$green" | cut -c1-2)
    blue_2d=$(echo "$blue" | cut -c1-2)
    
    echo ""
    echo "Approximate RGB (2-digit hex): #${red_2d}${green_2d}${blue_2d}"
else
    echo "Failed to get background color"
fi