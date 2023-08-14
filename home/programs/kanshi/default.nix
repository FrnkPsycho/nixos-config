{ pkgs, user, system, inputs, ...}:

{

  services.kanshi = {
    enable = true;
    profiles = {
        both = {
            outputs = [
                {
                    criteria = "HDMI-A-1";
                    position = "0,0";
                }
                {
                    criteria = "eDP-1";
                    position = "0,2160";
                }
            ];
        };

        laptop-only = {
            outputs = [
                {
                    criteria = "eDP-1";
                }
            ];
        };

        external-only = {
            outputs = [
                {
                    criteria = "HDMI-A-1";
                }
            ];
        };
    };
  };

}
