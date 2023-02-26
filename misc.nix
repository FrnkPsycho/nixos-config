# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, lib
, user
, ...
}:

#let
#    nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
#    export __NV_PRIME_RENDER_OFFLOAD=1
#    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
#    export __GLX_VENDOR_LIBRARY_NAME=nvidia
#    export __VK_LAYER_NV_optimus=NVIDIA_only
#    exec "$@"
#  '';
#in

 {
  # librarySystemDepends = [pkgs.zlib];
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  #environment.systemPackages = [ nvidia-offload ];
  #hardware.nvidia.prime = {
    #offload.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    #amdgpuBusId = "PCI:5:0:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
  #  nvidiaBusId = "PCI:1:0:0";
  #};
  #hardware.nvidia.powerManagement.enable = true;
  #hardware.nvidia.powerManagement.finegrained = true;
  # programs.hyprland.enable = true;
  programs.xwayland.enable = true;
  # programs.kdeconnect.enable = true;
  networking.extraHosts =
  ''
    127.0.0.1 www.sweetscape.com
  '';
  
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
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
        # nvidiaWayland = true;
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
        enable = true;
      };
      powerManagement = {
        enable = true;
        # finegrained = true;
      };
      # open = true;
    };
  };
  #hardware.nvidia.nvidiaPersistenced = true;
  #hardware.nvidia.modesetting.enable = true;
  
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
    # sway.enable = true;
    dconf.enable = true;
  };
  #  programs.waybar.enable = true;
  #
  #  # Enable the GNOME Desktop Environment.
  #  services.xserver.desktopManager.gnome.enable = false;
  #  services.xserver.videoDrivers = ["nvidia"];
  #  hardware.opengl.enable=true;
  #  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    #antialias = false;
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
      # noto-fonts-extra
      sarasa-gothic
      twemoji-color-font
      liberation_ttf
      corefonts
      wqy_zenhei
      wqy_microhei
      vistafonts
      vistafonts-chs
      vistafonts-cht
      #      font-awesome
      #      fira-code-symbols
      #    cascadia-code
    ] ++ (with (pkgs.callPackage ./modules/packs/glowsans/default.nix { }); [ glowsansSC glowsansTC glowsansJ ])
    ++ (with nur-pkgs;[
     # maple-font.Mono-NF-v5
     san-francisco 
     plangothic ]);
    #"HarmonyOS Sans SC" "HarmonyOS Sans TC"
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
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-configtool
    ];
  };
  #    enabled = "ibus";
  #    ibus.engines = with pkgs.ibus-engines; [
  #      libpinyin
  #      rime
  #    ];
  system.stateVersion = "22.11"; # Did you read the comment?
}
