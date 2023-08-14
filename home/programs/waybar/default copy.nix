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
      style = builtins.readFile ./waybar.css;
      systemd = {
        enable = true;
        # target = "hyprland-session.target";
      };
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 27;
          modules-left = [ "sway/mode" "sway/workspaces" "sway/window" ];
          
          modules-center = [ "clock" ];
          modules-right = 
            let
              base = [
                "idle_inhibitor"
                "network"
                "cpu"
                "memory"
                "battery"
                "tray"
              ];
            in              
            base;
          
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

          "wlr/workspaces" = {
           format = "{icon}";
           on-click = "activate";
           on-scroll-up = "${pkgs.hyprland}/bin/hyprctl dispatch workspace e-1";
           on-scroll-down = "${pkgs.hyprland}/bin/hyprctl dispatch workspace e+1";
          };
          "sway/window" = {
            max-length = 80;
            tooltip = false;
          };
          "tray" = {
            "icon-size" = 20;
            "spacing" = 5;
          };
          disk = {
            interval = 30;
            format = "{percentage_free}% free on {path}";
          };
          clock = {
            format = "{:%H:%M:%S}";
            timezone = "Asia/Shanghai";
            format-alt = "{:%a %d %b}";
            format-alt-click = "click-right";
            # on-click = "${lib.getExe pkgs.swaylock}";
            tooltip = true;
          };
          battery = {
            format = "{capacity}% {icon}";
            format-alt = "{time} {icon}";
            format-icons = [ "" "" "" "" "" ];
            format-charging = "{capacity}% ";
            interval = 10;
            states = {
              warning = 25;
              critical = 10;
            };
            tooltip = false;
          };
          cpu = {
            interval = 1;
            format = "{usage}% ";
            max-length = 10;
            min-length = 5;
          };
          memory = {
            interval = 1;
            format = "{}% ";
            max-length = 10;
            min-length = 5;
            tooltip = true;
          };
          network = {
            interval = 1;
            format-wifi = "󰖩 {essid} {bandwidthDownBytes}|{bandwidthUpBytes}";
            format-ethernet = "󰀂  {ifname} {bandwidthTotalBytes}|{bandwidthUpBytes}";
            format-linked = "󰖪 {essid} (No IP)";
            format-disconnected = "󰯡 Disconnected";
            
          };
          wireplumber = {
            format = "{volume}% {icon}";
            on-click = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
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
