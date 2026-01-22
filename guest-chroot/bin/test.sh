#!/bin/dash

# random_id=$(head -c 16 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 12)
# printf "\033]1337;MultipartFile=name=$(echo -n "$random_id.png" | base64);size=$(stat -f%z "/Users/hloth/Downloads/TgSticker_23bd8897.png"):\033\\"
# cat "/Users/hloth/Downloads/TgSticker_23bd8897.png" | base64 | fold -w 76 | while read -r line; do
# 	printf "%s\033\\" "$line"
# done
# printf "\033]1337;FileEnd\033\\"

printf "\033]1337;SetBadgeFormat=$(echo -n "hiiiiiiiiiiiii" | base64)\033\\"
printf "\033]9;Test\033\\"

printf "\033]9;Test\033\\"