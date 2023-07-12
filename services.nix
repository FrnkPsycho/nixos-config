{ config
, pkgs
, lib
, user
, ...
}:

{
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
  security.polkit.enable = true;
  security.pam.u2f.enable = true;

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "eurosign:e";
      videoDrivers = [ "nvidia" ];
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
      };
      displayManager.gdm = {
        enable = true;
        wayland = false;
      };
    };

    dbus.enable = true;

    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
    };

    flatpak.enable = true;
    udev.packages = [ pkgs.android-udev-rules pkgs.qmk-udev-rules (pkgs.callPackage ./modules/packs/opensk-udev-rules { }) ];
    gnome.gnome-keyring.enable = true;


    clash = {
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

    snapper = {
      snapshotRootOnBoot = true;
      snapshotInterval = "hourly";
      cleanupInterval = "1d";
      configs = {

        root = {
          SUBVOLUME = "/";
          ALLOW_USERS= ["${user}"];
          TIMELINE_CREATE=true;
          TIMELINE_CLEANUP=true;
        };

        home = {
          SUBVOLUME = "/home";
          ALLOW_USERS= [ "${user}" ];
          TIMELINE_CREATE=true;
          TIMELINE_CLEANUP=true;
        };

        nix = {
          SUBVOLUME = "/nix";
          ALLOW_USERS= [ "${user}" ];
          TIMELINE_CREATE=true;
          TIMELINE_CLEANUP=true;
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
       PasswordAuthentication = true;
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
  
}
    
