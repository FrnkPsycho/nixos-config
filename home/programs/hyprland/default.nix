{ pkgs, user, system, inputs, ...}:

{

  wayland.windowManager.hyprland = {
    enable = false;
    systemdIntegration = false;
    extraConfig = import ./config.nix { inherit pkgs user system inpuys; };

  };

}

