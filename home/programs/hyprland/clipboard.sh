cliphist store

if [ $1 == "text" ] ; then
  prefix=$'Copied Text to Clipboard:\n\n'
  content=$(wl-paste -p)
  notify-send -a Hyprland -t 3000 "${prefix}${content}"

elif [ $1 == "image" ] ; then
  notify-send -a Hyprland -t 3000 "Copied Image to Clipboard"
    
fi

mpv /etc/nixos/home/programs/hyprland/clipboard_notify.flac
