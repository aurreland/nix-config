#!/run/current-system/sw/bin/bash

calendar() {
LOCK_FILE="$HOME/.cache/eww-calendar.lock"
EWW_BIN="$HOME/.nix-profile/bin/eww"

run() {
    ${EWW_BIN} -c $HOME/.config/eww open calendar
}

# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
    ${EWW_BIN} -c $HOME/.config/eww close music_win audio_ctl
    touch "$LOCK_FILE"
    run && echo "ok good!"
else
    ${EWW_BIN} -c $HOME/.config/eww close calendar
    rm "$LOCK_FILE" && echo "closed"
fi
}


music() {
LOCK_FILE_SONG="$HOME/.cache/eww-song.lock"
EWW_BIN="$HOME/.nix-profile/bin/eww"

run() {
    ${EWW_BIN} -c $HOME/.config/eww open music_win 
}

# Open widgets
if [[ ! -f "$LOCK_FILE_SONG" ]]; then
    ${EWW_BIN} -c $HOME/.config/eww close system calendar
    touch "$LOCK_FILE_SONG"
    run && echo "ok good!"
else
    ${EWW_BIN} -c $HOME/.config/eww close music_win
    rm "$LOCK_FILE_SONG" && echo "closed"
fi
}



if [ "$1" = "calendar" ]; then
calendar
elif [ "$1" = "music" ]; then
music
elif [ "$1" = "audio" ]; then
pypr toggle volume
elif [ "$1" = "launcher" ]; then
wofi --show drun
fi