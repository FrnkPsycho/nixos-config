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

  services.dbus.enable = true;
  programs.xwayland.enable = true;

  
  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebkit-5.212.0-alpha4"
  ];
  
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];
  #my-nur-pkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfree = true;
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
  services.xserver =
    {
      enable = true;
      layout = "us";
      xkbOptions = "eurosign:e";
      dpi = 96;
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = false;
      };
    };
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
  
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = [ pkgs.mesa.drivers ];  
  };

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaPersistenced = true;
      modesetting = {
        enable = false;
      };
      powerManagement = {
        enable = true;
      };
      # open = true;
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
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "frnks" ];
    };
  };

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  #i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ja_JP.SJIS/SJIS" ];
  
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs = {
    fish.enable = true;
    dconf.enable = true;
  };
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [

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
      wqy_zenhei
      wqy_microhei
      vistafonts
      vistafonts-chs
      vistafonts-cht
    ] ++ (with (pkgs.callPackage ./modules/packs/glowsans/default.nix { }); [ glowsansSC glowsansTC glowsansJ ])
    ++ (with nur-pkgs;[
     # maple-font.Mono-NF-v5
     san-francisco 
     plangothic ]);

    fontconfig = {
      antialias = true;
      hinting = {
        enable = false;
        style = "hintnone";
      };
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
