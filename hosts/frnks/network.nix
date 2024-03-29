{ config
, pkgs
, ...
}: {
  networking = {

    hostName = "frnks"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    enableIPv6 = true;
    #interfaces.wan.wakeOnLan.enable = false;
    #interfaces.wan.useDHCP = true;

    # interfaces.enp4s0.useDHCP = true;
    #  interfaces.wlp5s0.useDHCP = true;
    #
    # Configure network proxy if necessary
    # proxy.default = "http://127.0.0.1:7890";

    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    wireless.iwd.enable = true;
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 
       7891  # clash LAN
       80    # http
       443   # https
       2234  # soulseek
       23946 # IDA remote debug
      ];
      allowedTCPPortRanges = [ {from = 1716; to = 1764;} ]; # kdeconnect ports
      allowedUDPPortRanges = [ {from = 1716; to = 1764;} ];
    };
      extraHosts =''
    127.0.0.1 www.sweetscape.com
    '';
  };
}
