#!/bin/bash

echo "debug {
    suppress_errors = true
}" >>~/.config/hypr/ignore.conf

CURRENT=$(cat /home/Will/Pictures/.current)
TOTAL=$(ls -l /home/Will/Pictures/ | wc -l)
TOTAL=$((TOTAL - 1))

pkill swaybg

if [[ $CURRENT -eq $TOTAL ]]; then
    CURRENT=0
fi

swaybg -i "/home/Will/Pictures/$((CURRENT + 1))" >/dev/null &
wal -i "/home/Will/Pictures/$((CURRENT + 1))"
cat /home/Will/.cache/wal/colors-sway | awk ' ($1 != "" && $2 != "$wallpaper") { print($2 "=" "rgb(" substr($3, 2) ")" ) } /wallpaper/ { print $2 "=" $3} ' >/home/Will/.cache/wal/colors-hypland.conf
mv -f /home/Will/.cache/wal/colors-kitty.conf /home/Will/.config/kitty/theme.conf

echo "$((CURRENT + 1))" >/home/Will/Pictures/.current
LINE_COUNT=$(wc -l ~/.config/hypr/hyprland.conf | cut -d " " -f 1)
LINE_COUNT=$((LINE_COUNT - 3))

echo "" >~/.config/hypr/ignore.conf

COLORS=($(cat ~/.cache/wal/colors | tr -d "#"))

cat /opt/spicetify-cli/Themes/SpicetifyDefault/color.ini | awk "
    /^\[/ { print }
    /^text/ { print(\"text = ${COLORS[7]}\") }
    /^subtext/ { print (\"subtext = ${COLORS[8]}\") }
    /^main/ { print (\"main = ${COLORS[0]}\")  }
    /^sidebar/ { print (\"sidebar = ${COLORS[0]}\") }
    /^player/ { print (\"player = ${COLORS[4]}\") }
    /^card/ { print (\"card = ${COLORS[2]}\") }
    /^shadow/ { print (\"shadow = ${COLORS[3]}\") }
    /^selected-row/ { print (\"selected-row = ${COLORS[8]}\") }
    /^button / { print (\"button = ${COLORS[6]}\") }
    /^button-active/ { print (\"button-active = ${COLORS[7]}\") }
    /^button-disabled/ { print (\"button-disabled = ${COLORS[5]}\") }
    /^tab-active/ { print (\"tab-active = ${COLORS[2]}\") }
    /^notification / { print (\"notification = ${COLORS[5]}\") }
    /^notification-error/ { print (\"notification-error = ${COLORS[4]}\") }
    /^misc/ { print (\"misc = ${COLORS[1]}\") }
" >/opt/spicetify-cli/Themes/SpicetifyDefault/file

mv -f /opt/spicetify-cli/Themes/SpicetifyDefault/file /opt/spicetify-cli/Themes/SpicetifyDefault/color.ini
# spicetify apply &

pkill swaync
swaync &
pywalfox update &

openrgb -d 0 -c ${COLORS[2]}
openrgb -d 1 -c ${COLORS[2]}
