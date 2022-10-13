{ config
, pkgs
, user
, ...
}: {
  users = {
    users.${user} = {
      isNormalUser = true;
      uid = 1000;
      group = "${user}";
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
        "audio"
        "libvirtd"
        "qemu-libvirtd"
        "kvm"
        "logindev"
        "plugdev"
        "openrazer"
      ]; # Enable ‘sudo’ for the user.
      shell = pkgs.fish;

      openssh.authorizedKeys.keys = [
        
      ];
    };
    users.root.shell = pkgs.zsh;

    users.proxy = {
      isSystemUser = true;
      group = "proxy";
    };

    groups = {
      ${user} = { };
      proxy = { };
    };
  };
  security.sudo.extraRules = [
    {
      users = [ "${user}" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
