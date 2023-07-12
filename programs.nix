{ config
, pkgs
, lib
, user
, ...
}:

{
    programs = {
        adb.enable = true;
        xwayland.enable = false;
        gamemode.enable = true;
        fish.enable = true;
        dconf.enable = true;
        ssh.startAgent = false;

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