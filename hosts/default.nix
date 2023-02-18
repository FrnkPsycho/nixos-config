{ inputs, system, ... }:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;

  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
    config.permittedInsecurePackages = [ "qtwebkit-5.212.0-alpha4" ];
    overlays = [
      (final: prev: {
        nur-pkgs = inputs.nur-pkgs.packages."${prev.system}";
      })
      inputs.nur.overlay
    ] ++ (import ../overlay.nix inputs);

  };

  sharedModules = [
    ../misc.nix
    ../users.nix
    ../boot.nix
    ../packages.nix
    ../sysvars.nix
    ../services.nix
    {
      environment.systemPackages = with inputs; [
        alejandra.defaultPackage.${system}
        # agenix.defaultPackage.${system}
        # helix.packages.${system}.default
      ];
    }
  ] ++ (with inputs;[

    # agenix.nixosModules
    grub2-themes.nixosModules.default
    home-manager.nixosModules.home-manager

  ]) ++ (import ../modules);


in
{
  frnks = nixosSystem (
    let user = "frnks"; in
    {
      inherit system pkgs;
      specialArgs = { inherit inputs system user; };
      modules = (import ./frnks) ++ sharedModules;
    }
  );
}
