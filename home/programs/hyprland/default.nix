{ pkgs, user, lib, inputs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    #package = null;
    #systemdIntegration = true;
    extraConfig = import ./config.nix { inherit pkgs user lib; };
    enableNvidiaPatches = true;
    #recommendedEnvironment = true;
    xwayland = {
      enable = true;
      #hidpi = true;
    };
    #systemd = {
    #  enable = true;
    #  
    #};
  };
  #home.sessionVariables = {
  #  XCURSOR_SIZE = "48";
  #};
}
