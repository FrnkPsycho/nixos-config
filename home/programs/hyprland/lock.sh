swayidle -w \
timeout 600 'systemctl suspend && hyprctl dispatch dpms off' \
resume ' hyprctl dispatch dpms on' \
before-sleep 'sh /etc/nixos/home/programs/hyprland/swaylock.sh'