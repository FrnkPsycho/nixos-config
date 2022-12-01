{ config, lib, pkgs, ... }:
{

  programs = {
    chromium = {
      enable = false;
      commandLineArgs = [ "--enable-features=UseOzonePlatform" "-ozone-platform=wayland" "--gtk-version=4" ];
    };
    google-chrome = {
      enable = false;
      commandLineArgs = [ "--enable-features=UseOzonePlatform" "-ozone-platform=wayland" "--gtk-version=4" ];
    };


  };

}
  
