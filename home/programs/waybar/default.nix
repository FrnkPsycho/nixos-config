{ user
, pkgs
, lib
, ...
}:
# let mkSpan = abbr: content: "<span color='#8aadf4'>${abbr}</span> ${content}";
# in
{
  programs = {
    waybar = {
      enable = true;
      package = pkgs.waybar;
      style = builtins.readFile ./waybar.css;
      systemd = {
        enable = false;
        target = "hyprland-session.target";
      };
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 28;
          spacing = 4;
          modules-left = [ "hyprland/submap" "hyprland/workspaces" "hyprland/window"];
          
          modules-center = [ "clock" ];
          
          modules-right = [ "network" "cpu" "memory" "disk" "battery" "tray" "wireplumber" ];

          "hyprland/submap"= {
            format = " {}";
            max-length = 16;
            tooltip = false;
          };
          "sway/mode" = {
            format = " {}";
          };
          "sway/workspaces" = {
            all-outputs = true;
            format = "{name}";
            disable-scroll = false;
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "|";
              deactivated = "-";
            };
          };

          "hyprland/workspaces" = {
           format = "{icon}";
           on-click = "activate";
           on-scroll-up = "hyprctl dispatch workspace m-1 > /dev/null";
           on-scroll-down = "hyprctl dispatch workspace m+1 > /dev/null";
           format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "󰒃";
            "5" = "";
            "6" = "󰮃";
            "9" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
            };
          };
          "hyprland/window" = {
            max-length = 100;
          };
          
          tray = {
            icon-size = 24;
          };
          disk = {
            interval = 30;
            on-click = "${pkgs.kitty}/bin/kitty ranger ~";
            format = "{free} 󰨣";
          };
          clock = {
            format = "{:%H:%M}";
            timezone = "Asia/Shanghai";
            format-alt = "{:%a %d %b}";
            format-alt-click = "click-right";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
                    "mode"          = "month";
                    "mode-mon-col"  = 3;
                    "weeks-pos"     = "right";
                    "on-scroll"     = 1;
                    "on-click-right"= "mode";
                    "format"= {
                              "months"=     "<span color='#ffead3'><b>{}</b></span>";
                              "days"=       "<span color='#ecc6d9'><b>{}</b></span>";
                              "weeks"=      "<span color='#99ffdd'><b>W{}</b></span>";
                              "weekdays"=   "<span color='#ffcc66'><b>{}</b></span>";
                              "today"=      "<span color='#ff6699'><b><u>{}</u></b></span>";
                              };
                    };
            actions =  {
                    "on-click-right"= "mode";
                    "on-click-forward"= "tz_up";
                    "on-click-backward"= "tz_down";
                    "on-scroll-up"= "shift_up";
                    "on-scroll-down"= "shift_down";
                    };
          };
          battery = {
            format = "{capacity}% {icon}";
            format-alt = "{time} {icon}";
            format-icons = [ "󰁻" "󰁽" "󰁿" "󰂁" "󰁹" ];
            format-charging = "{capacity}% 󰂄";
            interval = 10;
            states = {
              warning = 25;
              critical = 10;
            };
            tooltip = true;
          };
          cpu = {
            interval = 1;
            #on-click = "exec bash -c \"${pkgs.btop}/bin/btop\"";
            on-click = "${pkgs.kitty}/bin/kitty btop";
            tooltop = true;
            format = "{usage}% ";
            max-length = 10;
            min-length = 5;
          };
          memory = {
            interval = 1;
            on-click = "${pkgs.kitty}/bin/kitty btop";
            format = "{used:0.1f}G ";
            max-length = 10;
            min-length = 5;
            tooltip = true;
          };
          network = {
            interval = 1;
            on-click = "${pkgs.kitty}/bin/kitty nmtui";
            tooltip = true;
            format-wifi = "󰖩 {essid}  {bandwidthDownBytes} |  {bandwidthUpBytes}";
            tooltip-format = "{ifname} | {gwaddr}";
            format-ethernet = "󰀂 {ifname}  {bandwidthTotalBytes} |  {bandwidthUpBytes}";
            format-linked = "󰖪 {essid} (No IP)";
            format-disconnected = "󰯡 Disconnected";
            
          };
          mpris = {
            format = "DEFAULT: {player_icon} {dynamic}";
            format-pause = "DEFAULT: {status_icon} <i>{dynamic}</i>";
            player_icons = {
              default = "▶";
              mpv = "";
            };
            status_icons = {
              paused = "⏸";
            };
          };
          wireplumber = {
            format = "{volume}% {icon}";
            on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            format-muted = "x";
            format-icons = {
              phone = [ " " " " " 墳" " " ];
              default = [ "" "墳" "" ];
            };
            scroll-step = 1;
            tooltip = false;
          };
          temperature = {
            interval = 2;
            hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
            format = "{temperatureC}°C ";
            max-length = 10;
            min-length = 5;
            tooltip = false;
          };

          backlight = {
            format = "{icon}";
            format-alt = "{percent}% {icon}";
            format-alt-click = "click-right";
            format-icons = [ "" "" ];
            on-scroll-down = "light -A 1";
            on-scroll-up = "light -U 1";
          };
        };
      };
    };
  };
}
