{ pkgs
, config
, lib
, user
, ...
}:
with lib;
let
  cfg = config.services.sing-box;
  dataDir = "/home/${user}/.config/sing-box";
in
{
  options.services.sing-box = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc ''
        enable?
      '';

    };
    package = mkOption {
      type = types.package;
      default = pkgs.nur-pkgs.sing-box;
      defaultText = literalExpression "pkgs.sing-box";
      description = lib.mdDoc ''
        package
      '';
    };

  };
  config =
    let
      configFile = null;
#        pkgs.writeTextFile {
#          name = "config.json";
#          #          destination = "dataDir/config.json";
#          text = builtins.toJSON (import ./config.nix );
#        };

    in
    mkIf cfg.enable {
      systemd.services.sing-box = {
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        description = "sing-box Daemon";

        serviceConfig = {
          Type = "simple";
          User = user;
          WorkingDirectory = dataDir;
          ExecStart = "${cfg.package}/bin/sing-box run -c ${configFile}";
          CapabilityBoundingSet = [
            "CAP_NET_RAW"
            "CAP_NET_ADMIN"
            "CAP_NET_BIND_SERVICE"
          ];
          AmbientCapabilities = [
            "CAP_NET_RAW"
            "CAP_NET_ADMIN"
            "CAP_NET_BIND_SERVICE"
          ];
          Restart = "on-failure";
        };

      };

    };


}

