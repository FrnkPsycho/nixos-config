{ config
, pkgs
, lib
, user
, ...
}:

{
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  environment.etc = {
	  "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
	  	bluez_monitor.properties = {
			  ["bluez5.enable-sbc-xq"] = true,
			  ["bluez5.enable-msbc"] = true,
			  ["bluez5.enable-hw-volume"] = true,
			  ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		  }
	  '';
  };

  security.rtkit.enable = true;
  security.pam.u2f.enable = true;

  services = {
    flatpak.enable = true;
    udev.packages = [ pkgs.android-udev-rules pkgs.qmk-udev-rules (pkgs.callPackage ./modules/packs/opensk-udev-rules { }) ];
    gnome.gnome-keyring.enable = true;
          # pipewire.enable = true;
    #    hysteria.enable = true;

    # fstrim.enable = true;

    ss = {
      enable = false;
    };
    hysteria.enable = false;
    clash =
      {
        enable = true;
        # place config.yaml in ~/.config/clash

        # TUN setup should be like this: 
        #         
        # ebpf:
        #   auto-redir:
        #     - wan
        #   #  redirect-to-tun:
        # # - wan
        # 
        # #auto-redir:
        #   # enable: true
        #   #auto-route: true
        # tun:
        #   enable: false
        #   stack: gvisor # or gvisor
        #   dns-hijack:
        #     - 'any:53'
        #     - 'tcp://any:53'
        #   auto-route: false
      };

    sing-box = {
      enable = false;
    };

    snapper = {
      snapshotRootOnBoot = true;
      snapshotInterval = "hourly";
      cleanupInterval = "3d";
      configs = {

        root = {
          subvolume = "/";
          extraConfig = ''
            ALLOW_USERS="${user}"
            TIMELINE_CREATE=yes
            TIMELINE_CLEANUP=yes
          '';
        };

        home = {
          subvolume = "/home";
          extraConfig = ''
            ALLOW_USERS="${user}"
            TIMELINE_CREATE=yes
            TIMELINE_CLEANUP=yes
          '';
        };

        nix = {
          subvolume = "/nix";
          extraConfig = ''
            ALLOW_USERS="${user}"
            TIMELINE_CREATE=yes
            TIMELINE_CLEANUP=yes
          '';
        };
      };
    };


    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/home" "/nix" ];
    };
    pcscd.enable = true;

    openssh = {
      enable = true;
      settings = {
       X11Forwarding = true;
       PasswordAuthentication = false;
      };
      extraConfig = ''
        useDNS no
      '';
    };

    fail2ban = {
      enable = true;
      maxretry = 5;
      ignoreIP = [
        "127.0.0.0/8"
        "10.0.0.0/8"
        "172.16.0.0/12"
        "192.168.0.0/16"
      ];
    };

    resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      extraConfig = ''
        DNS=127.0.0.1:53
                  #223.6.6.6 101.6.6.6:5353 202.141.178.13:5353
        Domains=~.
        MulticastDNS=true
        DNSSEC=off
        DNSStubListener = false
        DNSOverTLS = false
      '';
      fallbackDns = [
        "101.6.6.6:5353"
        "211.138.151.161"
        "8.8.4.4"
        "1.1.1.1"
      ];

      llmnr = "true";
    };
  };

  qt.enable = true;
  qt.style = "adwaita";
  qt.platformTheme = "qt5ct";

  programs = {
    ssh.startAgent = false;
    proxychains = {
      enable = true;

      chain = {
        type = "strict";
      };
      proxies = {
        clash = {
          type = "socks5";
          host = "127.0.0.1";
          port = 7890;
        };
      };
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    tmux = {
      aggressiveResize = true;
      clock24 = true;
      enable = true;
      newSession = true;
      reverseSplit = true;

      plugins = with pkgs.tmuxPlugins; [
        prefix-highlight
        nord
      ];
    };
  };
}
    
