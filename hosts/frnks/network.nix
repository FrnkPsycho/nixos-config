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
  };
}
