{ pkgs, user, lib, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    systemdIntegration = true;
    extraConfig = import ./config.nix { inherit pkgs user lib; };
    enableNvidiaPatches = true;
    recommendedEnvironment = true;
    xwayland = {
      enable = true;
      #hidpi = true;
    };
  };
  #home.sessionVariables = {
  #  XCURSOR_SIZE = "48";
  #};
}
