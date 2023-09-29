{ pkgs
, user
, lib
, ...
}:
let

  # wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
  # wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
  # term = "${pkgs.alacritty}/bin/alacritty";
  genDeps = n: lib.genAttrs n (name: lib.getExe pkgs.${name});
  deps = genDeps [
    "fuzzel"
    "kitty"
    "grim"
    "light"
    "playerctl"
    "slurp"
    "swaybg"
    "hyprpicker"
    "cliphist"
    "firefox"
    "tdesktop"
    "save-clipboard-to"
    "screen-recorder-toggle"
    "systemd-run-app"
  ];


in
builtins.readFile ./mocha + (with deps; ''

  env = LIBVA_DRIVER_NAME,nvidia
  env = XDG_SESSION_TYPE,wayland
  env = GBM_BACKEND,nvidia-drm
  env = __GLX_VENDOR_LIBRARY_NAME,nvidia
  env = WLR_NO_HARDWARE_CURSORS,1
  #env = WLR_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1
  
  exec-once=mako
  exec-once=fcitx5
  exec-once=firefox
  exec-once=telegram-desktop
  exec-once=udiskie &
  # rt
  
  # This is a dirty approach since my waybar will be broken if some services aren't started
  # And it crashes randomly so I created a daemon service in home.nix
  exec-once=sleep 3; systemctl start --user waybar.service

  # This is a script for suspend handling
  exec-once=/etc/nixos/home/programs/hyprland/lock.sh
  
  bind=SUPER,RETURN,exec,kitty
  bind=SUPER,D,exec,fuzzel
  bind=SUPERSHIFT, P, exec, hyprpicker -a

  # exit mode
  bind=SUPER,escape,exec,hyprctl dispatch submap logout; notify-send -a Hyprland -t 3500 $'e - exit\n\nr - reboot\n\ns - suspend\n\nS - poweroff\n\nl - lock'
  submap=logout
  bindr =,E,exit,
  bindr =,S,exec,hyprctl dispatch submap reset && systemctl suspend
  bindr =,R,exec,systemctl reboot
  bindr =SHIFT,S,exec,systemctl poweroff -i
  bindr =,L,exec,hyprctl dispatch submap reset && swaylock
  bindr=,escape,submap,reset
  bind=,Return,submap,reset
  submap=reset

  bind=,XF86AudioRaiseVolume,exec,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
  bind=,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  bind=,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  bind=,XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
  bind=,XF86MonBrightnessUp,exec,light -A 5
  bind=,XF86MonBrightnessDown,exec,light -U 5
  bind=,XF86Calculator,exec,gnome-calculator
  # bind=,mouse:274,exec,wl-copy $(wl-paste -p)
  bind=SUPER CTRL, P, exec,  cliphist list | fuzzel -d -I -l 7 -x 8 -y 7 -P 9 -w 50 -b ede3e7d9 -r 3 -t 8b614db3 -C ede3e7d9 -f 'FiraCode Nerd Font:style=Regular:size=15' -P 10 -B 7 | cliphist decode | wl-copy

  bind=SUPERCTRL,R,exec,${screen-recorder-toggle}
  bind=SUPERCTRL,S,exec,${save-clipboard-to}

  # selection
  $ssselection=grimblast --notify --cursor copysave area ~/Pictures/Screenshots/$(date "+%Y-%m-%d"T"%H:%M:%S").png
  # $ssselection=grim -g "$(slurp)"

  # all-monitors
  $ssall=grimblast - | wl-copy -t image/png
    
  # Clipboard manager
  #exec-once = wl-paste --type text --watch cliphist store #Stores only text data
  #exec-once - wl-paste --type text --watch notify-send -a Hyprland -t 3000 "Copied Text to Clipboard"
  
  exec-once = wl-paste --type text --watch /etc/nixos/home/programs/hyprland/clipboard.sh text
  exec-once = wl-paste --type image --watch /etc/nixos/home/programs/hyprland/clipboard.sh image
  exec-once=swaybg -i /etc/nixos/home/programs/hyprland/bg.jpg 
  #exec-once=${systemd-run-app} ${tdesktop}
  #exec-once=firefox
  
'') + builtins.readFile ./general
