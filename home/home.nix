{ config
, pkgs
, inputs
, ...
}:
{
  imports = import ./programs;
  home.stateVersion = "22.11";
  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  android-sdk = {
    enable = true;
    path = "${config.home.homeDirectory}/.android/sdk";
    packages = sdk: with sdk; [
      build-tools-31-0-0
      cmdline-tools-latest
      emulator
      platforms-android-31
      sources-android-31
    ];
  };

  home.packages = let
  list1 = let pkgs = import inputs.my-nur-pkgs { 
  }; in with pkgs; [
    idafree
  ];

  list2 = with pkgs; [
    cider
    android-studio
    scrcpy
    firefox-wayland
    dolphin-emu
    # helix
    gzdoom
    mangohud
    #goverlay
    #retroarchFull
    blockbench-electron
    discord
    # mpris-scrobbler
    aseprite
    kchmviewer
    # scanmem
    #autokey
    qbittorrent
    wpsoffice
    iaito
    picard
    nur.repos.xddxdd.baidupcs-go
    nur.repos.xddxdd.svp
    audacious
    audacious-plugins
    qq
    lutris
    baobab
    libreoffice-fresh
    prismlauncher
    minder
    mpv
    filezilla
    aegisub
    chromium
    helvum
    # wpsoffice-cn
    nur.repos.linyinfeng.wemeet
    nur.repos.YisuiMilena.hmcl-bin
    # nur.repos.linyinfeng.icalingua-plus-plus
    spice-vdagent
    spice
    radare2
    ghidra
    bottles
    mdbook
    nur.repos.xddxdd.wechat-uos-bin
    obsidian
    gnome.nautilus
    gnome.gnome-calculator
    gnome.eog
    gnome.file-roller
    # gnomecast
    thunderbird
    tetrio-desktop
    ffmpeg_5-full
    fuzzel

    discord-canary
    qemu
    iwd

    ncdu_2 # disk space info

    # clipboard
    # xsel

    # thunderbird

    # spotify
    # nushell

    # geekbench5

    # wayfire

    btop
    smartmontools
    wireshark-qt
    wezterm
    android-tools
    tor-browser-bundle-bin
    # cargo-cross
    # android-studio
    zellij
    netease-cloud-music-gtk
    # cmatrix
    termius
    autojump
    nmap
    lm_sensors
    # eww-wayland
    # rofi
    # picom

    feh
    sl
    starship
    # texlive.
    # texlive.combined.scheme-full
    vlc
    # firefox-wayland
    bluedevil
    #zathura
    # jetbrains.clion
    # jetbrains.goland
    # jetbrains.pycharm-professional
    jetbrains.datagrip
    # jetbrains.phpstorm
    # jetbrains.webstorm
    jetbrains.idea-ultimate

    tdesktop
  ];

  # list3 = let pkgs = import inputs.android-nixpkgs { 
  # }; in with pkgs; [
  #   cmdline-tools-latest
  #   build-tools-32-0-0
  #   platform-tools
  #   platforms-android-31
  #   emulator
  # ];
  in
  list1 ++ list2;
  
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.nur-pkgs.Graphite-cursors; #callPackage ../modules/packs/Graphite-cursors { };
    name = "Graphite-light-nord";
    size = 18;
  };

  #systemd.services = {
  #  waybar = {
  #    serviceConfig = {
  #      ExecStart = 
  #    };
  #  };
  #};

  systemd.user.services = {
    waybar = {
      Unit.Description = "Waybar Auto-Restart Daemon Service";
      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
        RestartSec = "1s";
      };
      # Install.WantedBy = [ "hyprland-session.target" ];
    };
  };

  xdg.desktopEntries = {
    vscode = {
      name = "Visual Studio Code /w IME";
      exec = "code --enable-wayland-ime %F";
      categories = [ "Utility" "TextEditor" "Development" "IDE" ];
      icon = "code";
      genericName = "Text Editor";
      startupNotify = true;
      mimeType = [ "text/plain" "inode/directory" ];
      settings = {
        Keywords = "vscode";
        StartupWMClass = "Code";
      };
      actions = {
        "new-empty-window" = {
          exec = "code --new-window --enable-wayland-ime %F";
          icon = "code";
          name = "New Empty Window";
        };
      };
    };

    obsidian = {
      name = "Obsidian /w IME";
      exec = "obsidian %u --enable-wayland-ime";
      categories = [ "Office" "TextEditor" ];
      icon = "obsidian";
      mimeType = [ "x-scheme-handler/obsidian" ];
    };
  };

  services = {
    
    mako = {
      enable = true;
      backgroundColor = "#1E1D2Fa6";
      borderSize = 1;
      borderColor = "#96CDFB3b";
      maxVisible = 2;
      borderRadius = 10;
      defaultTimeout = 5000;
      font = "JetBrainsMono Nerd Font 20";
      width = 600;
      height = 400;
      maxIconSize = 100;

      extraConfig = ''
      '';
    };
  };

  programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
    
    git = {
      enable = true;
      userName = "frnkpsycho";
      userEmail = "frnkpsycho@gmail.com";
    };

    zsh = {
      enable = true;
      shellAliases = {
        nd = "cd /etc/nixos";
        n = "neovide";
        off = "poweroff";
        proxy = "proxychains4 -f /home/riro/.config/proxychains/proxychains.conf";
        roll = "xrandr -o left && feh --bg-scale /home/riro/Pictures/Wallpapers/95448248_p0.png && sleep 0.5; picom --experimental-backend -b";
        rolln = "xrandr -o normal && feh --bg-scale /home/riro/Pictures/Wallpapers/秋の旅.jpg && sleep 0.5;  picom --experimental-backend -b";
        cat = "bat";
        kls = "exa";
        sl = "exa";
        ls = "exa";
        l = "exa -l";
        la = "exa -la";
        g = "lazygit";
      };
      history = {
        ignoreDups = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
        share = true;
        path = "${config.xdg.dataHome}/zsh_history";
      };

      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      defaultKeymap = "emacs";
      initExtra = ''
        eval $(starship init zsh)
      '';
      loginExtra = ''
        if
          [[ $(id --user $USER) == 1000 ]] && [[ $(tty) == "/dev/tty1" ]]
        then
          exec sway
        fi
      '';

      plugins = [
        #        {
        #          # will source zsh-autosuggestions.plugin.zsh
        #          name = "zsh-autosuggestions";
        #          src = pkgs.fetchFromGitHub {
        #            owner = "zsh-users";
        #            repo = "zsh-autosuggestions";
        #            rev = "v0.7.0";
        #            sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        #          };
        #        }
        #        {
        #          name = "enhancd";
        #          file = "init.sh";
        #          src = pkgs.fetchFromGitHub {
        #            owner = "b4b4r07";
        #            repo = "enhancd";
        #            rev = "v2.2.4";
        #            sha256 = "sha256-9/JGJgfAjXLIioCo3gtzCXJdcmECy6s59Oj0uVOfuuo=";
        #          };
        #        }
        {
          name = "zsh-history-substring-search";
          file = "zsh-history-substring-search.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-history-substring-search";
            rev = "4abed97b6e67eb5590b39bcd59080aa23192f25d";
            sha256 = "sha256-8kiPBtgsjRDqLWt0xGJ6vBBLqCWEIyFpYfd+s1prHWk=";
          };
        }
        {
          name = "sudo";
          file = "plugins/sudo/sudo.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "ohmyzsh";
            repo = "ohmyzsh";
            rev = "957dca698cd0a0cafc6d2551eeff19fe223f41bd";
            sha256 = "sha256-fafbsXO29/lqLDcffkdEiXrC9R7PJiRuyNSlTUTErdI=";
          };
        }
        {
          name = "man";
          file = "plugins/man/man.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "ohmyzsh";
            repo = "ohmyzsh";
            rev = "25d0b2dfbd4f4c915a9c04e29a97b82ebd4e612c";
            sha256 = "sha256-fafbsXO29/lqLDcffkdEiXrC9R7PJiRuyNSlTUTErdI=";
          };
        }
      ];
      #      loginShellInit = ''
      #        if
      #          [[ $(id --user $USER) == 1000 ]] && [[ $(tty) == "/dev/tty1" ]]
      #        then
      #          exec sway
      #        fi
      #      '';
    };
    autojump.enable = true;

    obs-studio = {
      enable = true;
      plugins = with pkgs; [ obs-studio-plugins.wlrobs ];
    };

    home-manager.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--info=inline"
        "--border"
        "--exact"
      ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
      name = "Adwaita";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Light";
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
