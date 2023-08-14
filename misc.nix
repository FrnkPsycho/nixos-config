# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, lib
, user
, ...
}:

 {

  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebkit-5.212.0-alpha4"
    "electron-21.4.0"
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];

  nixpkgs.config.allowUnfree = true;
  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
    };
  };

  nix = {
    #     settings.substituters = [ "https://mirrors.bfsu.edu.cn/nix-channels/store" ];
    package = pkgs.nixVersions.stable;
    settings = {
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nur-pkgs.cachix.org-1:PAvPHVwmEBklQPwyNZfy4VQqQjzVIaFOkYYnmnKco78="
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://nur-pkgs.cachix.org"
      ];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "ca-derivations" ];
      trusted-users = [ "root" "frnks" ];
    };
  };

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [

      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DroidSansMono"
          "JetBrainsMono"
          "FantasqueSansMono"
          "CascadiaCode"
        ];
      })
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      sarasa-gothic
      twemoji-color-font
      liberation_ttf
      corefonts
      vistafonts
      vistafonts-chs
      vistafonts-cht
    ] ++ (with (pkgs.callPackage ./modules/packs/glowsans/default.nix { }); [ glowsansSC glowsansTC glowsansJ ])
    ++ (with nur-pkgs;[
     san-francisco 
     plangothic ]);

    fontconfig = {
      antialias = true;
      hinting.enable = false;
      subpixel = {
        lcdfilter = "light";
      };
      defaultFonts = {
        serif = [ "Glow Sans SC" "Glow Sans TC" "Glow Sans J" "Noto Serif" "Noto Serif CJK SC" "Noto Serif CJK TC" "Noto Serif CJK JP" ];
        monospace = [ "SF Mono" ];
        sansSerif = [ "Glow Sans SC" "Glow Sans TC" "Glow Sans J" "SF Pro Text" ];
        emoji = [ "twemoji-color-font" "noto-fonts-emoji" ];
      };
    };
  };
  
  i18n.inputMethod = {
    # enabled = "ibus";
    # ibus.panel = "${pkgs.plasma5Packages.plasma-desktop}/lib/libexec/kimpanel-ibus-panel";
    enabled = "fcitx5";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
      typing-booster
      table
      rime
      table-chinese
      uniemoji
    ];
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-mozc
      fcitx5-lua
      fcitx5-table-other
      fcitx5-rime
      libsForQt5.fcitx5-qt
      fcitx5-gtk
      fcitx5-configtool
    ];
  };
  system.stateVersion = "22.11"; # Did you read the comment?
}
