{ config
, pkgs
, inputs
, lib
, user
, system
, ...
}:

{
    programs = {
        adb.enable = true;
        light.enable = true;
        # sway.enable = true;
        # waybar.enable = true;
        xwayland.enable = true;
        gamemode.enable = true;
        fish.enable = true;
        dconf.enable = true;
	command-not-found.enable = true;
        ssh.startAgent = false;

	nix-index = {
	    enable = false;
	    enableFishIntegration = true;
	    enableBashIntegration = true;
	};

        gamescope = {
            enable = true;
            capSysNice = false;
        };

        hyprland = {
            enable = true;
            package = (import inputs.nixpkgs-wlroots {
               system = "x86_64-linux";
            }).pkgs.hyprland;
            xwayland = {
                # hidpi = true;
                enable = true;
            };
            # enableNvidiaPatches = true;
        };

        steam = {
            enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        };

        java = {
            enable = true;
            package = pkgs.jdk17;
        };

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
